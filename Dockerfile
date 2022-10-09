FROM alpine
RUN apk add swi-prolog --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
WORKDIR /srv
ENTRYPOINT [ "swipl", "-g", "consult('*.pl')" ]
