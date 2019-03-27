# FIXME local base image name used for testing purpose
FROM lpe12proto/lava-server-base:alpine

COPY lava-*.install /tmp/
COPY entrypoint.sh /root/

RUN git clone -b postinst https://git.lavasoftware.org/fabo/lava.git /tmp/lava ;\
    cd /tmp/lava ;\
    # FIXME python3 setup.py build
    make -C doc/v2/ html SPHINXBUILD="/usr/local/bin/sphinx-build" SPHINXOPTS="-j 4 -D today=\"$(LC_ALL=C date -u "+%B %d, %Y")\"" ;\
    rm -f doc/v2/_build/html/objects.inv ;\
    find lava_*/static/lava_*/js/ -type f ! -name *.min.js ! -name *.flot.stack.js ! -name *.flot.time.js -delete ;\
    python3 setup.py install --prefix=/usr/local --root="git/lava" ;\
    python3 setup.py clean -a ;\
    find . -path '*/__pycache__/*' -delete ;\
    find . -type d -name '__pycache__' -delete ;\
    # Create LAVA system user/group
    addgroup -S lavaserver ;\
    adduser -h /var/lib/lava-server/home -s /bin/sh -G lavaserver -S lavaserver ;\
    # Run shell scripts to install files and create symlinks
    sh -ex /tmp/lava-common.install ;\
    sh -ex /tmp/lava-server.install ;\
    # Enable apache2 configuration and modules
    sed -i '/LoadModule expires_module/s/^#//g' /etc/apache2/httpd.conf ;\
    echo "IncludeOptional /etc/apache2/sites-available/*.conf" >> /etc/apache2/httpd.conf ;\
    echo "export APACHE_LOG_DIR=/var/log/apache2" >> /usr/sbin/envvars ;\
    # Uncomment some gunicorn default values
    sed -i '/LOGLEVEL/s/^# //g' /etc/lava-server/lava-server-gunicorn ;\
    sed -i '/LOGFILE/s/^# //g' /etc/lava-server/lava-server-gunicorn ;\
    sed -i '/WORKERS/s/^# //g' /etc/lava-server/lava-server-gunicorn ;\
    # Create users entrypoint directory
    mkdir -p /root/entrypoint.d ;\
    # List packages and python modules installed
    apk info -vv | sort ;\
    pip freeze ;\
    # Cleanup
    rm -rf /tmp/lava-*.install /tmp/lava/

EXPOSE 80 5500 5555 5556

ENTRYPOINT ["/root/entrypoint.sh"]
