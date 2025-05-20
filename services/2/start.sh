#!/bin/sh
ip r replace default via 192.168.8.254

exec python3 -m http.server
