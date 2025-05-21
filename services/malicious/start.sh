#!/bin/sh
ip r add 192.168.7.0/24 via 192.168.6.254
ip r add 192.168.8.0/24 via 192.168.6.254
exec python3 -m http.server 5000
