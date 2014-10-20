# Tilestache Container

An extension of: https://github.com/jagregory/docker-tilestache

A basic Tilestache setup, with PIL and Mapnik and native dependencies. Supports
the Mapnik providers, PNG, and JPEG output.


This image also includes an endpoint script to start a running tilestache
server (using uWSGI as the wsgi server).

Example usage:
    docker run -it -p 8080:8080 --volume=path/to/tilestache.cfg:/var/tilestache/tilestache.cfg:ro -rm tnris/tilestache

This will start a tilestache server, running on port 8080 using the config file
at path/to/tilestache.cfg
