FROM alpine:3.5

RUN apk update && \
    apk --no-cache --update add libgcc libstdc++ ncurses-libs libcrypto1.0 && \
    rm -rf /var/cache/apk/*
