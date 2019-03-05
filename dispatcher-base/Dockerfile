FROM python:3.7-alpine3.9

ENV BUILD_DEPS="\
    build-base \
    linux-headers \
    yaml-dev \
"

# FIXME uboot-tools (mkimage) and libguestfs are only available on Alpine Edge
ENV RUNTIME_DEPS="\
    busybox-extras \
    git \
    libguestfs@testing \
    libmagic \
    lxc \
    lxc-templates \
    nfs-utils \
    qemu-system-aarch64 \
    qemu-system-x86_64 \
    ser2net \
    tftp-hpa \
    uboot-tools@testing \
    yaml \
"

COPY requirements.txt ./

RUN apk add --no-cache --virtual .build-deps ${BUILD_DEPS} ;\
    echo "@testing http://uk.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories ;\
    apk add --no-cache ${RUNTIME_DEPS} ;\
    pip install --no-cache-dir -r requirements.txt ;\
    # Install supervisord from git using pip
    pip install --no-cache-dir -e git+https://github.com/Supervisor/supervisor.git#egg=supervisor ;\
    install -D -p -m0644 /src/supervisor/supervisor/skel/sample.conf /etc/supervisord.conf ;\
    # List packages and python modules installed
    apk info -vv | sort ;\
    pip freeze ;\
    # Cleanup
    apk del --no-cache --purge .build-deps ;\
    rm -rf /var/cache/apk/* /requirements.txt
