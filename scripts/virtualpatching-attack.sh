#!/bin/sh

KNOWN_DEVICES="192.168.7.69 192.168.8.69"

if [ -z "$KNOWN_DEVICES" ]; then
  echo "ERROR: Please set \$KNOWN_DEVICES to a space-separated list of IPs"
  exit 1
fi

_send() {
  proto=$1; ip=$2; port=$3; payload=$4
  if [ "$proto" = "tcp" ]; then
    printf "$payload" | nc -w1 "$ip" "$port"
  else
    printf "$payload" | nc -u -w1 "$ip" "$port"
  fi
}

_repeat_nulls() {
  count=$1
  seq=""
  i=0
  while [ "$i" -lt "$count" ]; do
    seq="${seq}\\x00"
    i=$((i + 1))
  done
  printf "%s" "$seq"
}

trigger_modbus_single_coil() {
  payload="\\x00\\x01\\x00\\x00\\x00\\x06\\x01\\x05\\x00\\x01\\xFF\\x00"
  for ip in $KNOWN_DEVICES; do
    _send tcp "$ip" 502 "$payload"
  done
}

trigger_modbus_multiple_coils() {
  payload="\\x00\\x02\\x00\\x00\\x00\\x07\\x01\\x10\\x00\\x01\\x00\\x02\\x01\\x05"
  for ip in $KNOWN_DEVICES; do
    _send tcp "$ip" 502 "$payload"
  done
}

trigger_dnp3_direct_operate() {
  prefix=$(_repeat_nulls 15)
  for ip in $KNOWN_DEVICES; do
    printf "${prefix}\\x05" | nc -w1 "$ip" 20000
  done
}

trigger_dnp3_select_operate() {
  prefix=$(_repeat_nulls 15)
  for ip in $KNOWN_DEVICES; do
    printf "${prefix}\\x06" | nc -w1 "$ip" 20000
  done
}

trigger_bacnet_whois_flood() {
  prefix=$(_repeat_nulls 7)
  payload="${prefix}\\x08\\xFF"
  for ip in $KNOWN_DEVICES; do
    i=0
    while [ "$i" -lt 60 ]; do
      printf "$payload" | nc -u -w1 "$ip" 47808
      i=$((i + 1))
    done
  done
}

trigger_bacnet_readproperty() {
  prefix=$(_repeat_nulls 7)
  for ip in $KNOWN_DEVICES; do
    printf "${prefix}\\x0C" | nc -u -w1 "$ip" 47808
  done
}

trigger_s7_write_variable() {
  prefix=$(_repeat_nulls 10)
  for ip in $KNOWN_DEVICES; do
    printf "${prefix}\\x05" | nc -w1 "$ip" 102
  done
}

echo "[*] MODBUS single coil..."
trigger_modbus_single_coil

echo "[*] MODBUS multiple coils..."
trigger_modbus_multiple_coils

echo "[*] DNP3 direct operate..."
trigger_dnp3_direct_operate

echo "[*] DNP3 select/operate..."
trigger_dnp3_select_operate

echo "[*] BACnet WhoIs flood..."
trigger_bacnet_whois_flood

echo "[*] BACnet ReadProperty..."
trigger_bacnet_readproperty

echo "[*] Siemens S7 write variable..."
trigger_s7_write_variable

echo "[+] Done. Check Suricata alerts for SIDs 1000029-1000035."