# Suricata-Testing

## Objective
Setup suricata in IDS mode (and IPS if needed) to protect a simulated industrial network.

## Network structure
     +-----+         +-----+
     |  A  |         |  B  |
     +-----+         +-----+
         \             /
          \           /
           \         /
             +-----+           +-----+
             |  S  | --------- |  M  |
             +-----+           +-----+
                ⇅            /
          .~~~~~~~~~~~.     /
       .~~   INTERNET   ~~.
      '~~~~~~~~~~~~~~~~~~~'

S is the main router and sniffs the forwarded packets to find potential threats using suricata. The ruleset is defined in custom.rules and to use it you need to decomment "suricata-update" in start.sh.

## Tests
the scripts to run from the Malicious container (M) are in the scripts folder and should make requests to the internal network for suricata to see the traffic.

## GUI
The gui is accessible at http://localhost:3000

The data is from ElasticSearch, so to make the dashboard you have to make a new connection to an ElasticSearch origin (http://elasticsearch:9200) and create the dashboard from there.