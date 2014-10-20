#!/bin/bash
set -e

if [ "$1" = 'tilestache' ]; then
    CONFIG_FILE=$2

    if [ -z $CONFIG_FILE ]; then
        CONFIG_FILE="/var/tilestache/tilestache.cfg"
    fi

    echo "Using tilestache config: $CONFIG_FILE"
    exec uwsgi --http :8080 --eval "import TileStache; \
        application = TileStache.WSGITileServer(\"$CONFIG_FILE\")"
fi

exec "$@"
