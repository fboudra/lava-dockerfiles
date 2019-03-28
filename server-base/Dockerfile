FROM python:3.7-alpine3.9

ENV BUILD_DEPS="\
    build-base \
    linux-headers \
    openldap-dev \
    postgresql-dev \
    yaml-dev \
"

ENV RUNTIME_DEPS="\
    apache2-ctl \
    apache2-proxy \
    apache2-utils \
    git \
    libldap \
    libmagic \
    libzmq \
    make \
    postgresql-client \
    tftp-hpa \
    yaml \
"

COPY requirements.txt /tmp/

RUN apk update ;\
    apk add --no-cache --virtual .build-deps ${BUILD_DEPS} ;\
    apk add --no-cache ${RUNTIME_DEPS} ;\
    pip install --no-cache-dir -r /tmp/requirements.txt ;\
    # Create symlinks
    ln -sf /usr/local/bin/gunicorn /usr/bin/gunicorn3 ;\
    ln -sf /usr/local/bin/python3 /usr/bin/python3 ;\
    ln -sf /usr/sbin/apachectl /usr/sbin/apache2ctl ;\
    # List packages and python modules installed
    apk info -vv | sort ;\
    pip freeze ;\
    # Cleanup
    apk del --no-cache --purge .build-deps ;\
    rm -rf /var/cache/apk/* /tmp/*
