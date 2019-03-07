#!/bin/sh

set -e

[ -n "$1" ] && exec "$@"

# Set default variables
LOGGER_URL=${LOGGER_URL:-tcp://localhost:5555}
LOGLEVEL=${LOGLEVEL:-DEBUG}
LOGFILE=${LOGFILE:--}
MASTER_URL=${MASTER_URL:-tcp://localhost:5556}
MASTER_URL_HOST=$(echo "$MASTER_URL" | awk -F// '{ print $2 }' | awk -F: '{ print $1 }')
MASTER_URL_PORT=$(echo "$MASTER_URL" | awk -F// '{ print $2 }' | awk -F: '{ print $2 }')

# Import variables
[ -e /etc/lava-dispatcher/lava-slave ] && . /etc/lava-dispatcher/lava-slave

for f in /root/entrypoint.d/*; do
    case "$f" in
        *.sh)
            echo "$0: running ${f}"
            "${f}"
            ;;
        *)
        echo "$0: ignoring ${f}"
        ;;
    esac
done

until nc -z "$MASTER_URL_HOST" "$MASTER_URL_PORT" > /dev/null 2>&1; do
  sleep 1
done

exec /usr/bin/lava-slave --level "$LOGLEVEL" --log-file "$LOGFILE" --master "$MASTER_URL" --socket-addr "$LOGGER_URL" $IPV6 $ENCRYPT $MASTER_CERT $SLAVE_CERT $DISPATCHER_HOSTNAME
