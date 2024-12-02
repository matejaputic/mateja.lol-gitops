Cloned this repo: https://github.com/YellowRoseCx/koboldcpp-rocm

Install `hipblas hipblaslt hipsparse hipcub` libraries with apt.

Then ran:
```sh
make LLAMA_HIPBLAS=1 -j20
```

Define `HIP_VISIBLE_DEVICES=0` before running.
Define `HSA_OVERRIDE_GFX_VERSION=11.0.0` before running.

```sh
python3 koboldcpp.py --threads 6 --blasthreads 6 --usecublas mmq lowvram --gpulayers 18 --blasbatchsize 256 --contextsize 8192 --model Llama-3.1-8B-Instruct-Q4_K_M.gguf
python3 koboldcpp.py --threads 6 --blasthreads 6 --usecublas mmq lowvram --gpulayers 24 --blasbatchsize 256 --contextsize 8192 --model Llama-3.1-8B-Instruct-Q4_K_M.gguf
cd /workspace/
curl -L -o Llama-3.2-8B-Instruct-Q8_0.gguf https://huggingface.co/mradermacher/Llama-3.2-8B-Instruct-GGUF/resolve/main/Llama-3.2-8B-Instruct.Q8_0.gguf?download=true
ll
ls -alt
vim run.sh
sh ./run.sh Llama-3.1-8B-Instruct-Q4_K_M.gguf
vim run.sh
vim run.sh Llama-3.
sh ./run.sh Llama-3.1-8B-Instruct-Q4_K_M.gguf
sh ./run.sh Llama-3.2-8B-Instruct-Q8_0.gguf
vim run.sh
sh ./run.sh Llama-3.2-8B-Instruct-Q8_0.gguf
vim run.sh
sh ./run.sh Llama-3.2-8B-Instruct-Q8_0.gguf
```

The 780M is called `gfx1103`.
