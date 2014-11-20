# Modified from:
#   https://github.com/TNRIS/docker-tilestache
#   by TNRIS App Team <contact@tnris.org>
#   which was modified from
#   https://github.com/jagregory/docker-tilestache
#   by James Gregory <james@jagregory.com>
 
FROM ubuntu:14.04
MAINTAINER Robert Trencheny <me@robbiet.us>

# install Python and all the dependencies
RUN apt-get update -y \
    && apt-get install -y \
        libjpeg-dev \
        zlib1g-dev \
        python \
        python-setuptools \
        python-dev \
        python-pip \
        python-gdal \
        libboost-python-dev \
        software-properties-common

# symlink the native extensions so Python can pick them up
RUN ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib
RUN ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib
RUN ln -s /usr/lib/x86_64-linux-gnu/libboost_python.so /usr/lib
RUN ln -s /usr/lib/x86_64-linux-gnu/libboost_thread.so /usr/lib

# install tilestache and dependencies
RUN pip install \
    Blit \
    jinja2 \
    --allow-external PIL --allow-unverified PIL PIL \
    boto \
    redis \
    simplejson \
    sympy \
    tilestache \
    uwsgi \
    werkzeug

VOLUME ["/var/tilestache"]

WORKDIR /var/tilestache

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY ./application.wsgi /var/tilestache/application.wsgi

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["tilestache"]
