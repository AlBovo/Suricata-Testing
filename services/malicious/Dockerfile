FROM python:3.13-alpine

RUN apk add curl \
&& apk add bind-tools \
&& apk add coreutils

COPY start.sh .
COPY run_scripts.sh .

ENTRYPOINT [ "./start.sh" ]
