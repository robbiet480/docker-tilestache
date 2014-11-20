# TileStache Container

An extension of [TNRIS's](https://github.com/TNRIS) [docker-tilestache](https://github.com/TNRIS/docker-tilestache) which in itself is an extension of [jagregory's](https://github.com/jagregory) [docker-tilestache](https://github.com/jagregory/docker-tilestache)

A basic [TileStache](http://tilestache.org/) setup with PIL and native dependencies. 
There's no Mapnik support, as it's dependencies are pretty large and unnecessary if just using url proxy.
S3, memcached and Redis support is included

This image also includes an endpoint script to start a running TileStache
server (using uWSGI as the wsgi server).

Example usage: `docker run -p 8080:8080 --volume=path/to/tilestache.cfg:/var/tilestache/tilestache.cfg:ro -rm robbiet480/tilestache`

This will start a TileStache [Redis StatusServer](http://tilestache.org/doc/TileStache.Goodies.StatusServer.html), running on port 8080 using the config
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
