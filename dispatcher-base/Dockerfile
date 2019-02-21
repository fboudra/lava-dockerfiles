FROM python:3.7-alpine3.9

ENV BUILD_DEPS="\
    build-base \
    linux-headers \
"

# FIXME uboot-tools (mkimage) is only available on Alpine Edge
#wget https://ftp.yzu.edu.tw/Linux/alpine/edge/testing/x86_64/uboot-tools-2018.09-r0.apk
ENV RUNTIME_DEPS="\
    git \
    lxc \
    lxc-templates \
    qemu-system-aarch64 \
    qemu-system-x86_64 \
    ser2net \
    tftp-hpa \
"

COPY requirements.txt ./

RUN apk add --no-cache --virtual .build-deps ${BUILD_DEPS} ;\
    apk add --no-cache ${RUNTIME_DEPS} ;\
    pip install --no-cache-dir -r requirements.txt ;\
    # Cleanup
    apk del --no-cache --purge .build-deps ;\
    rm -rf /var/cache/apk/* /requirements.txt
