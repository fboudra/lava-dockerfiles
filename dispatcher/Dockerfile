# FIXME local base image name used for testing purpose
FROM lpe12proto/lava-dispatcher-base:alpine

COPY lava-*.install /tmp/
COPY entrypoint.sh /root/
COPY overlays/etc/* /etc/

RUN git clone -b postinst https://git.lavasoftware.org/fabo/lava.git /tmp/lava ;\
    cd /tmp/lava ;\
    # FIXME python3 setup.py build
    find lava_*/static/lava_*/js/ -type f ! -name *.min.js ! -name *.flot.stack.js ! -name *.flot.time.js -delete ;\
    python3 setup.py install --prefix=/usr/local --root="git/lava" ;\
    python3 setup.py clean -a ;\
    find . -path '*/__pycache__/*' -delete ;\
    find . -type d -name '__pycache__' -delete ;\
    # Run shell scripts to install files and create symlinks
    sh -ex /tmp/lava-common.install ;\
    sh -ex /tmp/lava-dispatcher.install ;\
    # Create users entrypoint directory
    mkdir /root/entrypoint.d ;\
    # List packages and python modules installed
    apk info -vv | sort ;\
    pip freeze ;\
    # Cleanup
    rm -rf /tmp/lava-*.install /tmp/lava/

ENTRYPOINT ["/root/entrypoint.sh"]
