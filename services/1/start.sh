#!/bin/sh
ip r del default
ip r add default via 192.168.7.254

exec python3 -m http.server 5000 # stay up
