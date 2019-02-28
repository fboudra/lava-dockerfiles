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
    postgresql-client \
    tftp-hpa \
    yaml \
"

COPY requirements.txt package.json ./

RUN apk add --no-cache --virtual .build-deps ${BUILD_DEPS} ;\
    apk add --no-cache ${RUNTIME_DEPS} ;\
    pip install --no-cache-dir -r requirements.txt ;\
    # Install supervisord from git using pip
    pip install --no-cache-dir -e git+https://github.com/Supervisor/supervisor.git#egg=supervisor ;\
    install -D -p -m0644 /src/supervisor/supervisor/skel/sample.conf /etc/supervisord.conf ;\
    # Install javascript libraries
    yarn install --modules-folder /usr/share/javascript ;\
    # Removed IE_VERSION variable due to undefined error on trident browser engine
    sed -i '/IE_VERSION/d' /usr/share/javascript/excanvas.js/excanvas.js ;\
    # Remove excanvas copy in jquery-flot
    rm -f /usr/share/javascript/jquery-flot/excanvas.* ;\
    # Cleanup unwanted javascript libraries dependencies
    find /usr/share/javascript -type d -maxdepth 1 -mindepth 1 ! -name jquery-typeahead ! -name jquery-flot ! -name jquery ! -name excanvas.js | xargs rm -rf {} ;\
    # Cleanup
    yarn cache clean ;\
    apk del --no-cache --purge .build-deps ;\
    rm -rf /var/cache/apk/* /requirements.txt /package.json
