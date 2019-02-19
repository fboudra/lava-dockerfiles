FROM python:3.7-alpine3.9

ENV BUILD_DEPS="\
    build-base \
    linux-headers \
    openldap-dev \
    postgresql-dev \
"

ENV RUNTIME_DEPS="\
    git \
    tftp-hpa \
"

# FIXME django-restricted-resource latest release isn't available on pypi
COPY requirements.txt ./

RUN apk add --no-cache --virtual .build-deps ${BUILD_DEPS} \
  && apk add --no-cache ${RUNTIME_DEPS} \
  && pip install --no-cache-dir -r requirements.txt \
  && apk del --no-cache --purge .build-deps \
  && rm -rf /var/cache/apk/*
