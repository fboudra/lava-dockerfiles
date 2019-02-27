FROM python:3.7-alpine3.9

ENV BUILD_DEPS="\
    build-base \
    linux-headers \
    openldap-dev \
    postgresql-dev \
    unzip \
    yarn \
"

ENV RUNTIME_DEPS="\
    apache2-ctl \
    apache2-proxy \
    apache2-utils \
    git \
    libldap \
    libzmq \
    postgresql-client \
    tftp-hpa \
"

COPY requirements.txt package.json ./

RUN apk add --no-cache --virtual .build-deps ${BUILD_DEPS} ;\
    apk add --no-cache ${RUNTIME_DEPS} ;\
    pip install --no-cache-dir -r requirements.txt ;\
    # Install supervisord from git using pip
    pip install --no-cache-dir -e git+https://github.com/Supervisor/supervisor.git#egg=supervisor ;\
    install -D -p -m0644 /src/supervisor/supervisor/skel/sample.conf /etc/supervisord.conf ;\
    # Install javascript libraries
    # Note: jquery-cookie is superseded by js-cookie. With 1.5.1 release being
    # the last backward compatible version
    yarn install ;\
    # Removed IE_VERSION variable due to undefined error on trident browser engine
    sed -i '/IE_VERSION/d' /node_modules/excanvas.js/excanvas.js ;\
    # Remove excanvas copy in jquery-flot
    rm -f /node_modules/jquery-flot/excanvas.*
    # jquery-watermark isn't available on npm registry (last release is Aug 13, 2012)
    wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/jquery-watermark/jquery.watermark-3.1.4.zip ;\
    mkdir -p  node_modules/jquery-watermark ;\
    unzip jquery.watermark-3.1.4.zip -d node_modules/jquery-watermark/ ;\
    # Cleanup
    apk del --no-cache --purge .build-deps ;\
    rm -rf /var/cache/apk/* /requirements.txt /package.json /*.zip
