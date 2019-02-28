# FIXME local base image name used for testing purpose
FROM lpe12proto/lava-server-base:alpine

COPY lava-*.install /tmp/
COPY overlays/etc/supervisor.d/*.conf /etc/supervisor.d/
COPY overlays/etc/lava-server/* /etc/lava-server/

RUN git clone -b postinst https://git.lavasoftware.org/fabo/lava.git /tmp/lava ;\
    cd /tmp/lava ;\
    # FIXME python3 setup.py build
    make -C doc/v2/ html SPHINXBUILD="/usr/local/bin/sphinx-build" SPHINXOPTS="-j 4 -D today=\"$(LC_ALL=C date -u "+%B %d, %Y")\"" ;\
    rm -f doc/v2/_build/html/objects.inv ;\
    python3 setup.py install --prefix=/usr/local --root="git/lava" ;\
    python3 setup.py clean -a ;\
    find . -path '*/__pycache__/*' -delete ;\
    find . -type d -name '__pycache__' -delete ;\
    # Run shell scripts to install files and create symlinks
    sh -ex /tmp/lava-common.install ;\
    sh -ex /tmp/lava-server.install ;\
    # Create LAVA system user/group
    addgroup -S lavaserver ;\
    adduser -h /var/lib/lava-server/home -s /bin/sh -G lavaserver -S lavaserver ;\
    # Enable apache2 configuration and modules
    sed -i '/LoadModule expires_module/s/^#//g' /etc/apache2/httpd.conf ;\
    echo "IncludeOptional /etc/apache2/sites-available/*.conf" >> /etc/apache2/httpd.conf ;\
    echo "export APACHE_LOG_DIR=/var/log/apache2" >> /usr/sbin/envvars ;\
    # Uncomment some gunicorn default values
    sed -i '/LOGLEVEL/s/^# //g' /etc/lava-server/lava-server-gunicorn ;\
    sed -i '/LOGFILE/s/^# //g' /etc/lava-server/lava-server-gunicorn ;\
    sed -i '/WORKERS/s/^# //g' /etc/lava-server/lava-server-gunicorn ;\
    # Create gunicorn3 symlink for convenience
    ln -sf /usr/local/bin/gunicorn /usr/bin/gunicorn3 ;\
    # Configure supervisord to include config snippet
    echo "[include]" >> /etc/supervisord.conf ;\
    echo "files = /etc/supervisor.d/*.conf" >> /etc/supervisord.conf ;\
    # List packages and python modules installed
    apk info -vv | sort ;\
    pip freeze ;\
    # Cleanup
    rm -rf /tmp/lava-*.install /tmp/lava/

EXPOSE 80 5500 5555 5556

# FIXME start/run the services

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf", "-n"]
