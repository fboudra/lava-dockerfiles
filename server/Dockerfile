# FIXME local base image name used for testing purpose
FROM lpe12proto/lava-server-base:alpine

ENV APACHE_LOG_DIR /var/log/apache2

COPY lava-*.install /tmp/

RUN git clone https://git.lavasoftware.org/lava/lava.git /tmp/lava ;\
    cd /tmp/lava ;\
    # FIXME python3 setup.py build
    python3 setup.py install --prefix=/usr/local --root="git/lava" ;\
    python3 setup.py clean -a ;\
    find . -path '*/__pycache__/*' -delete ;\
    find . -type d -name '__pycache__' -delete ;\
    # Run shell scripts to install files and create symlinks
    sh -x /tmp/lava-common.install ;\
    sh -x /tmp/lava-server.install ;\
    # Enable apache2 configuration and modules
    sed -i '/LoadModule expires_module/s/^#//g' /etc/apache2/httpd.conf ;\
    echo "IncludeOptional /etc/apache2/sites-available/*.conf" >> /etc/apache2/httpd.conf ;\
    # Create gunicorn3 symlink for convenience
    ln -sf /usr/local/bin/gunicorn /usr/bin/gunicorn3 ;\
    # List packages and python modules installed
    apk info -vv | sort ;\
    pip freeze ;\
    # Cleanup
    rm -rf /tmp/lava-*.install /tmp/lava/

EXPOSE 80 5500 5555 5556

# FIXME start/run the services
