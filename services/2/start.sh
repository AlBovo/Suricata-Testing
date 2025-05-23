#!/bin/sh
ip r del default
ip r add default via 192.168.8.254

nc -lnvp 502 &
nc -lnvp 20000 &
nc -lnvp 47808 &
nc -lnvp 102 &

exec python3 -m http.server 5000
