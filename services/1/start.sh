#!/bin/sh
ip r del default
ip r add default via 192.168.7.254

python3 -m http.server 8888 &
exec python3 -m http.server 80 # stay up
