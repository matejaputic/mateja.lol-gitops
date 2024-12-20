#! /usr/bin/env bash

# Thanks to [davralin/cluster-ops](https://github.com/davralin/cluster-ops)
# Thanks to [xunholy/k8s-ops](https://github.com/xunholy/k8s-gitops)

helm upgrade \
    cilium \
    cilium/cilium \
    --install \
    --version 1.16.4 \
    --namespace kube-system \
    --set ipam.mode=kubernetes \
    --set kubeProxyReplacement=true \
    --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set cgroup.autoMount.enabled=false \
    --set cgroup.hostRoot=/sys/fs/cgroup \
    --set k8sServiceHost=localhost \
    --set k8sServicePort=7445 \
    --wait --timeout=5m

# HELM INSTALL FLUX
helm upgrade \
    flux2 \
    fluxcd-community/flux2 \
    --install \
    --version 2.14.0 \
    --create-namespace \
    --namespace flux-system \
    --set imageAutomationController.create=false \
    --set imageReflectionController.create=false \
    --set clusterDomain=cluster.internal \
    --wait --timeout=5m

# DECRYPT AND APPLY THE DATA ENCRYPTION KEY (DEK)
# ASSUMES YOU HAVE THE KEY ENCRYPTION KEY (KEK) LOCALLY
sops --decrypt kubernetes/flux-system/sops-agekey.enc.yaml |kubectl apply -f -

# APPLY THE CLUSTER-WIDE SECRET CONFIG
# sops --decrypt kubernetes/flux-system/cluster-config-secret.enc.yaml |kubectl apply -f -

# APPLY THE CLUSTER-WIDE (NON-SECRET) CONFIG
# kubectl apply -f kubernetes/flux-system/cluster-config.yaml

# HELM INSTALL FLUX SYNC
helm upgrade \
    flux2-sync \
    fluxcd-community/flux2-sync \
    --install \
    --version 1.10.0 \
    --create-namespace \
    --namespace flux-system \
    --set gitRepository.spec.url=https://github.com/matejaputic/mateja.lol-gitops \
    --set gitRepository.spec.ref.branch=main \
    --set kustomization.spec.path=./kubernetes/flux-system \
    --set kustomization.spec.prune=true \
    --wait --timeout=5m