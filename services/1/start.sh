#!/bin/sh
ip r del default
ip r add default via 192.168.7.254

sleep 3
ping -c 1 192.168.8.69

./tmNIDS.sh -99 # run all tests
exec python3 -m http.server 5000 # stay up
