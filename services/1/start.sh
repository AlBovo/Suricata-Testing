#!/bin/sh
ip r del default
ip r add default via 192.168.7.254

sleep 10 # wait for suricata to load
./tmNIDS.sh -99 # run all tests

exec python3 -m http.server 5000 # stay up
