FROM alpine
RUN apk add swi-prolog --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
CMD [ "swipl" ]
