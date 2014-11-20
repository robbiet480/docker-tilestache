# Tilestache Container

An extension of: https://github.com/jagregory/docker-tilestache

A basic Tilestache setup, with PIL and Mapnik and native dependencies. Supports
the Mapnik providers, PNG, and JPEG output.


This image also includes an endpoint script to start a running tilestache
server (using uWSGI as the wsgi server).

Example usage: `docker run -p 8080:8080 --volume=path/to/tilestache.cfg:/var/tilestache/tilestache.cfg:ro -rm tnris/tilestache`

This will start a basic tilestache server, running on port 8080 using the config
file at path/to/tilestache.cfg . The config will be run through the jinja2
template engine with environment variables available for substitution. This
allows easy access to linked docker containers. For example, this config file:

    {
        "cache": {
            "name": "Redis",
            "host": "{{REDIS_PORT_6379_TCP_ADDR}}",
            "port": "{{REDIS_PORT_6379_TCP_PORT}}",
            "db": 0,
            "key prefix": "tilestache"
        },
        "layers": {
            ...
        }
    }


Would work with a linked redis container:

    docker run -d --name some-redis redis
    docker run -p 8080:8080 --volume=path/to/tilestache.cfg:/var/tilestache/tilestache.cfg:ro --link=some-redis:redis -rm tnris/tilestache
