"""
Small script that processes a file with the jinja template engine, with OS
environment variables available to the template. Mostly intended to allow config
to point to linked containers (e.g. using a redis container as a cache backend).
"""

import os

import jinja2
import TileStache
import TileStache.Goodies.StatusServer

application = None

infile = 'tilestache.cfg'
outfile = 'tilestache-cfg-rendered.cfg'

try:
    env = jinja2.Environment(loader=jinja2.FileSystemLoader('./'))
    template = env.get_template(infile)
    rendered = template.render(os.environ)
except Exception as e:
    print("Error rendering template: " + e.message)
    with open(infile, 'rb') as f:
        rendered = f.read()

with open(outfile, 'wb') as f:
    f.write(rendered)

if os.getenv('REDIS_PORT_6379_TCP_ADDR'):
  application = TileStache.Goodies.StatusServer.WSGIServer(outfile, redis_host=os.getenv('REDIS_PORT_6379_TCP_ADDR'), redis_port=os.getenv('REDIS_PORT_6379_TCP_PORT'))
else:
  application = TileStache.WSGITileServer(outfile)