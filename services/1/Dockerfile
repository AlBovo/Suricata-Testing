FROM python:3.13-alpine

COPY tmNIDS.sh .

RUN apk add curl \
&& apk add bind-tools \
&& apk add coreutils

COPY start.sh .
ENTRYPOINT [ "./start.sh" ]
