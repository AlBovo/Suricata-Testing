#!/bin/bash
sysctl net.ipv4.conf.all.forwarding=1
exec suricata -c /etc/suricata/suricata.yaml -i eth0 -v