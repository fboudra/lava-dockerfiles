FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

ENV BUILD_DEPS="\
    gcc \
    libldap2-dev \
    libmagic-dev \
    libpq-dev \
    libsasl2-dev \
    libyaml-dev \
    libzmq3-dev \
    python3-dev \
"

ENV RUNTIME_DEPS="\
    apache2 \
    ca-certificates \
    git \
    make \
    postgresql-client \
    tftpd-hpa \
    wget \
"

COPY requirements.txt /tmp/

RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7 ;\
    apt update -q=2 ;\
    apt install -q=2 --yes --no-install-recommends ${RUNTIME_DEPS} ${BUILD_DEPS} ;\
    wget -q https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py ;\
    python3 /tmp/get-pip.py ;\
    pip install --no-cache-dir -r /tmp/requirements.txt ;\
    # Create symlinks
    ln -sf /usr/local/bin/gunicorn /usr/bin/gunicorn3 ;\
    # List python modules installed
    pip freeze ;\
    # Cleanup
    apt-get clean ;\
    rm -rf /var/lib/apt/lists/* /tmp/*
