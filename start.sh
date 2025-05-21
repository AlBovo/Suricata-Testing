#!/bin/bash
# NAT (if needed)
# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -I FORWARD -j NFQUEUE --queue-num 0 # pass to suricata only forwarded packets, not the ones from the host
suricata-update # comment to keep only the rules in custom.rules
exec suricata -c /etc/suricata/suricata.yaml -q 0