#!/bin/bash
sysctl net.ipv4.conf.all.forwarding=
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -I FORWARD -j NFQUEUE --queue-num 0 # pass to suricata only forwarded packets, not the ones from the host
exec suricata -c /etc/suricata/suricata.yaml -q 0