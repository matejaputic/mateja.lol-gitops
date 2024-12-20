FROM mcr.microsoft.com/vscode/devcontainers/base:0-focal

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN unset DISPLAY
ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOF
apt -y update 
apt -y install \
    python3.8-venv \
    python3.9-full \
    python3.9-dev \
    build-essential \
    iputils-ping \
    libpq-dev \
    postgresql-client
EOF

USER vscode

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 -