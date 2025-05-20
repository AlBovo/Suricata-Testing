#!/bin/sh
ip r del default
ip r add default via 192.168.8.254

sleep 3
ping -c 1 192.168.7.69

exec python3 -m http.server 5000
