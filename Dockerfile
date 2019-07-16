FROM alpine:latest

RUN apk upgrade --no-cache \
    && apk add --no-cache --virtual .build-deps curl

CMD curl -X POST -H 'Content-type: application/json' --data '{"text":"test"}' ${WEBHOOK_URL}

