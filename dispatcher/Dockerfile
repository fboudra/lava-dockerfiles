# FIXME local base image name used for testing purpose
FROM lpe12proto/lava-dispatcher-base:debian

COPY lava-*.install /tmp/
COPY overlays/root/*.sh /root/
COPY overlays/etc/* /etc/

RUN git clone -b master https://git.lavasoftware.org/lava/lava.git /tmp/lava ;\
    cd /tmp/lava ;\
    python3 setup.py install --prefix=/usr/local --root="git/lava" ;\
    python3 setup.py clean -a ;\
    find . -path '*/__pycache__/*' -delete ;\
    find . -type d -name '__pycache__' -delete ;\
    # Run shell scripts to install files and create symlinks
    sh -ex /tmp/lava-common.install ;\
    sh -ex /tmp/lava-dispatcher.install ;\
    # Create users entrypoint directory
    mkdir -p /root/entrypoint.d ;\
    # List python modules installed
    pip freeze ;\
    # Cleanup
    rm -rf /tmp/*

ENTRYPOINT ["/root/entrypoint.sh"]
