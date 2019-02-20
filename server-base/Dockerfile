FROM python:3.7-alpine3.9

ENV BUILD_DEPS="\
    build-base \
    linux-headers \
    openldap-dev \
    postgresql-dev \
"

ENV RUNTIME_DEPS="\
    apache2-ctl \
    apache2-proxy \
    apache2-utils \
    git \
    supervisor \
    tftp-hpa \
"

COPY requirements.txt ./

RUN apk add --no-cache --virtual .build-deps ${BUILD_DEPS} ;\
    apk add --no-cache ${RUNTIME_DEPS} ;\
    pip install --no-cache-dir -r requirements.txt ;\
    # Cleanup
    apk del --no-cache --purge .build-deps ;\
    rm -rf /var/cache/apk/*
