FROM python:3.13-alpine

COPY start.sh .
COPY tmNIDS.sh .

RUN apk add curl \
    && apk add bind-tools \
    && apk add coreutils

ENTRYPOINT [ "./start.sh" ]
