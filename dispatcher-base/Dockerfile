FROM python:3.7-alpine3.9

ENV BUILD_DEPS="\
    build-base \
    linux-headers \
    yaml-dev \
"

# FIXME uboot-tools (mkimage) and libguestfs are only available on Alpine Edge
ENV RUNTIME_DEPS="\
    busybox-extras \
    eudev \
    git \
    iproute2 \
    libmagic \
    lxc \
    lxc-templates \
    nfs-utils \
    openssh-client \
    qemu-system-aarch64 \
    qemu-system-x86_64 \
    ser2net \
    supermin@testing \
    tftp-hpa \
    uboot-tools@community \
    xz \
    yaml \
"

COPY requirements.txt /tmp/

RUN echo "@testing http://uk.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories ;\
    echo "@community http://uk.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories ;\
    apk update ;\
    apk add --no-cache --virtual .build-deps ${BUILD_DEPS} ;\
    apk add --no-cache ${RUNTIME_DEPS} ;\
    # FIXME libguestfs python 3 bindings built using python 3.7
    wget -q http://people.linaro.org/~fathi.boudra/alpine/fabo/x86_64/libguestfs-1.40.2-r0.apk ;\
    wget -q http://people.linaro.org/~fathi.boudra/alpine/fabo/x86_64/py37-libguestfs-1.40.2-r0.apk ;\
    apk add --no-cache --allow-untrusted *.apk ;\
    pip install --no-cache-dir -r /tmp/requirements.txt ;\
    # Create symlink
    ln -sf /usr/local/bin/python3 /usr/bin/python3 ;\
    # List packages and python modules installed
    apk info -vv | sort ;\
    pip freeze ;\
    # Cleanup
    apk del --no-cache --purge .build-deps ;\
    rm -rf /var/cache/apk/* /tmp/* /*.apk
