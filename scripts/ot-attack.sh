#!/bin/sh

echo "LOL here we go %p" | nc 192.168.7.69 5000

echo "payload-tcp" | nc 192.168.7.69 44818

echo "payload-udp" | nc -1u -1w 192.168.7.69 2222

for i in $(seq 1 50); do echo $i | nc 192.168.8.69 5000; done

echo "Done."
