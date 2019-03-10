#!/bin/sh

set -e

APPLIANCE=appliance-1.38.0.tar.xz

printf "Download ${APPLIANCE}\n"
curl -sLSO http://download.libguestfs.org/binaries/appliance/${APPLIANCE}
mkdir -p /usr/lib/guestfs/
printf "Extract ${APPLIANCE}\n"
tar --strip-components=1 -C /usr/lib/guestfs/ -xf ${APPLIANCE}
rm -f ${APPLIANCE}
printf "Install ${APPLIANCE} done\n"
