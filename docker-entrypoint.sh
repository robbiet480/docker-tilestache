#!/bin/bash
set -e

if [[ "$1" = 'tilestache' ]]; then
    shift 1
    UWSGI_ARGS=$1

    if [[ -z $UWSGI_ARGS ]]; then
        UWSGI_ARGS="--wsgi-file /var/tilestache/application.wsgi"
    fi

    exec uwsgi --http :8080 $UWSGI_ARGS
fi

exec "$@"
