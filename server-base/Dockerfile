FROM python:3.7-alpine3.9

ENV BUILD_DEPS="\
    build-base \
    linux-headers \
    openldap-dev \
    postgresql-dev \
    yaml-dev \
    yarn \
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

COPY requirements.txt package.json ./

RUN apk update ;\
    apk add --no-cache --virtual .build-deps ${BUILD_DEPS} ;\
    apk add --no-cache ${RUNTIME_DEPS} ;\
    pip install --no-cache-dir -r requirements.txt ;\
    # Install javascript libraries
    yarn install --modules-folder /usr/share/javascript ;\
    # Removed IE_VERSION variable due to undefined error on trident browser engine
    sed -i '/IE_VERSION/d' /usr/share/javascript/excanvas.js/excanvas.js ;\
    # Remove excanvas copy in jquery-flot
    rm -f /usr/share/javascript/jquery-flot/excanvas.* ;\
    # Cleanup unwanted javascript libraries dependencies
    find /usr/share/javascript -type d -maxdepth 1 -mindepth 1 ! -name jquery-typeahead ! -name jquery-flot ! -name jquery ! -name excanvas.js | xargs rm -rf {} ;\
    # Create symlinks
    ln -sf /usr/local/bin/gunicorn /usr/bin/gunicorn3 ;\
    ln -sf /usr/local/bin/python3 /usr/bin/python3 ;\
    ln -sf /usr/sbin/apachectl /usr/sbin/apache2ctl ;\
    # List packages and python modules installed
    apk info -vv | sort ;\
    pip freeze ;\
    # Cleanup
    yarn cache clean ;\
    apk del --no-cache --purge .build-deps ;\
    rm -rf /var/cache/apk/* /requirements.txt /package.json
