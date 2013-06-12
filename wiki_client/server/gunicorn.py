import os
bind = "0.0.0.0:3005"
workers = 3
worker_class = 'gevent'
debug = True
daemon = True
pidfile = "/tmp/gunicorn.pid"
logfile = "/tmp/gunicorn.log"
