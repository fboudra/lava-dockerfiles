FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

ENV BUILD_DEPS="\
    gcc \
    libc6-dev \
    libmagic-dev \
    libyaml-dev \
    python3-dev \
"

ENV RUNTIME_DEPS="\
    ca-certificates \
    git \
    iproute2 \
    libguestfs-tools \
    lxc \
    nfs-kernel-server \
    openssh-client \
    python3-guestfs \
    qemu-system-arm \
    qemu-system-x86 \
    ser2net \
    telnet \
    tftpd-hpa \
    u-boot-tools \
    wget \
    xz-utils \
"

COPY requirements.txt /tmp/

RUN apt update -q=2 ;\
    apt install -q=2 --yes --no-install-recommends ${RUNTIME_DEPS} ${BUILD_DEPS} ;\
    wget -q https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py ;\
    python3 /tmp/get-pip.py ;\
    pip install --no-cache-dir -r /tmp/requirements.txt ;\
    # FIXME https://git.lavasoftware.org/lava/lava/issues/262
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash ;\
    export NVM_DIR="$HOME/.nvm" ;\
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" ;\
    nvm install v10.15.3 ;\
    npm install terser -g ;\
    # List python modules installed
    pip freeze ;\
    # Cleanup
    apt-get clean ;\
    rm -rf /var/lib/apt/lists/* /tmp/*
