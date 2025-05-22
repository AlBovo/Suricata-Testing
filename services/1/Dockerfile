FROM python:3.13-alpine

RUN apk add curl \
    && apk add bind-tools \
    && apk add coreutils

COPY tmNIDS.sh .
COPY start.sh .
ENTRYPOINT [ "./start.sh" ]
