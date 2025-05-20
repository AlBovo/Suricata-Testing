FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        wget \
        apt-transport-https \
        gnupg2 && \
    add-apt-repository ppa:oisf/suricata-stable -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends suricata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r suricata && useradd -r -g suricata suricata


COPY suricata.yaml /etc/suricata/suricata.yaml
RUN chown suricata:suricata /etc/suricata/suricata.yaml
COPY custom.rules /var/lib/suricata/rules/custom.rules
RUN chown suricata:suricata /var/lib/suricata/rules/custom.rules


RUN mkdir -p /var/log/suricata && chown -R suricata:suricata /var/log/suricata

COPY start.sh .

ENTRYPOINT ["./start.sh"]
