#!/bin/sh
ip r del default
ip r add default via 192.168.8.254

nc -lnvp 5000
echo "lol unknown" | nc 192.168.8.69 5000
echo "Done."