FROM alpine:latest

RUN apk add --no-cache python3 py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install pytest hypothesis \
    && rm -rf /var/cache/apk/*
