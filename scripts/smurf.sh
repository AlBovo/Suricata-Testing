#!/bin/sh
for i in `seq 1 254`; do
    ping -c 3 -W 1 192.168.7.$i;
done