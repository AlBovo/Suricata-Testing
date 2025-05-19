FROM ubuntu:latest

RUN apt-get update && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:oisf/suricata-stable -y && \
    apt-get update && \
    apt-get install suricata jq -y

ENTRYPOINT [ "suricata.sh" ]
