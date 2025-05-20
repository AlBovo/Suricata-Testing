#!/bin/sh

test_uid_name="Linux UID"
test_basicauth_name="HTTP Basic Authentication"
test_useragent_name="HTTP Malware User-Agent"
test_badcas_certs_name="Bad Certificates & CAs"
test_tor_name="Tor .onion DNS response and known IPs connection"
test_exe_name="EXE or DLL download over HTTP"
test_pdf_name="PDF download with Embedded File"
test_22scan_name="Simulate SSH Outbound Scan"
test_miscdns_name="Miscellaneous domains (TLD's, Sinkhole, DDNS, etc)"
test_filesharing_name="Anonymous filesharing website"
test_external_ip_lookup_name="External IP Address Lookup"
test_url_shortener_name="URL Shortener"
test_gaming_name="Policy Violation - Gaming"
test_adware_pup_name="Adware PUP"
test_malware_c2_beacon_name="Malware - Command & Control - Beacon"

# Define the actual tests

test_uid () {
  curl -s http://testmynids.org/uid/index.html > /dev/null
}

test_basicauth () {
  curl -s -H "Authorization: Basic cm9vdDpyb290" testmynids.org > /dev/null
}

test_useragent () {
  curl -s -A "BlackSun" testmynids.org > /dev/null
  curl -s -A "HttpDownload" testmynids.org > /dev/null
  curl -s -A "agent" testmynids.org > /dev/null
  curl -s -A "MSIE" testmynids.org > /dev/null
  curl -s -A "JEDI-VCL" testmynids.org > /dev/null
}

test_badcas_certs () {
  curl -s https://edellroot.badssl.com/ > /dev/null # sid: 2022134
  curl -s https://superfish.badssl.com/ > /dev/null # sid: 2020493
  echo Q | openssl s_client -showcerts -servername example.livehost.live -connect example.livehost.live:443 > /dev/null 2>&1 # sid: 2029345, 2029346
  echo Q | openssl s_client -showcerts -servername analiticsweb.site -connect analiticsweb.site:443 > /dev/null 2>&1 # sid: 2033098
  echo Q | openssl s_client -showcerts -servername adguard.clroot.io -connect adguard.clroot.io:443 > /dev/null 2>&1 # sid: 2045597
  echo Q | openssl s_client -showcerts -servername cryptpad.disroot.org -connect cryptpad.disroot.org:443 > /dev/null 2>&1 # sid: 2053979
  echo Q | openssl s_client -showcerts -servername beetrootculture.com -connect beetrootculture.com:443 > /dev/null 2>&1 # sid: 2054198, 2054200
  curl -s https://analiticsweb.site/ > /dev/null # sid: 2033098
  curl -s https://adguard.clroot.io/ > /dev/null # sid: 2045597
  curl -s https://cryptpad.disroot.org/ > /dev/null # sid: 2053979
  curl -s https://beetrootculture.com/ > /dev/null # sid: 2054198, 2054200
  curl -s testmynids.org/content_for_tests/2021941.txt > /dev/null # sid: 2021941
}

test_tor () {
  # Sample response with .onion
  dig a 3wzn5p2yiumh7akj.onion @8.8.8.8 > /dev/null

  # Retrieve Tor IP list and connect to 10
  curl -s https://raw.githubusercontent.com/SecOps-Institute/Tor-IP-Addresses/master/tor-nodes.lst -o /tmp/tor.list >/dev/null 2>&1
  # Randomize it
  sort --random-sort /tmp/tor.list > /tmp/randomtor.list
  # Connect to them
  head -n10 /tmp/randomtor.list | while read line; do nc -z -w 4 $line 443 2>&1; done
  # Clean temporary files
  rm /tmp/tor.list
  rm /tmp/randomtor.list
}

test_exe () {
  curl -s http://testmynids.org/exe/calc.exe -o /tmp/calc.exe
}

test_pdf () {
  curl -s testmynids.org/pdf/pdf.pdf -o /tmp/tmnidspdf.pdf 
  rm /tmp/tmnidspdf.pdf
}

test_22scan () {
  nc testmynids.org 22 -w3 > /dev/null
}

test_miscdns () {
  dig sinkhole.cert.pl @8.8.8.8 > /dev/null
  dig nic.su @8.8.8.8 > /dev/null
  dig invalid.no-ip.com @8.8.8.8 > /dev/null
}

test_filesharing () {
  echo Q | openssl s_client -connect fromsmash.com:443 > /dev/null 2>&1
}

test_external_ip_lookup () {
  curl -s api.ipify.org > /dev/null # sid: 2021997, 2047702, 2047703
  curl -s ipinfo.io > /dev/null # sid: 2020716, 2025331
  curl -s icanhazip.com > /dev/null # sid: 2036304, 2017398
  curl -s ifconfig.io > /dev/null # sid: 2844906
  curl -s checkip.amazonaws.com > /dev/null # sid: 2052027, 2814787
  curl -s ip-api.com > /dev/null # sid: 2022082
}

test_url_shortener () {
  curl -s zshorten.com > /dev/null # sid: 2038992
  curl -s cutt.ly > /dev/null # sid: 2038568
  curl -s lk.tc > /dev/null # sid: 2035742
}

test_gaming () {
  curl -s -H "User-Agent: (Nintendo Wii; U; ; 2047-12; en)" testmynids.org > /dev/null # sid: 2014718
  curl -s testmynids.org/Second_Life_Setup.exe > /dev/null #sid: 2013910
}

test_adware_pup () {
  curl -s testmynids.org/php/rpc_uci.php > /dev/null # sid: 2003060
  curl -s "testmynids.org/keywords/kyf?partner_id=123" > /dev/null # sid: 2002001
  curl -s testmynids.org/protector.exe > /dev/null # sid: 2002092
}

test_malware_c2_beacon () {
   curl -s -X POST testmynids.org -H 'Content-Type: application/txt' -d '=eyJHVUlEIjoi=IlR5cGUiOJUeXBlIj' > /dev/null # sid: 2027793
   curl -s testmynids.org/somepage.html?1234567890 -H 'User-Agent: sleep 20, Mozilla/5.0' > /dev/null # sid: 2016568
}


test_uid;
test_basicauth;
test_useragent;
test_badcas_certs;
test_tor;
test_exe;
test_pdf;
test_22scan;
test_miscdns;
test_filesharing;
test_external_ip_lookup;
test_url_shortener;
test_gaming;
test_adware_pup;
test_malware_c2_beacon;
