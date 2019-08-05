# build stage
FROM golang:latest AS build-env

ENV GO111MODULE auto
ENV CGO_ENABLED 0

ADD . /src
WORKDIR /src
RUN go build -o docker-slack *.go

# final stage
FROM alpine

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

WORKDIR /app
COPY --from=build-env /src/docker-slack /app/
ENTRYPOINT ./docker-slack