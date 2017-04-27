FROM alpine:3.5

RUN \
  set -xe \
  && apk update \
  && apk --no-cache --update add \
    libcrypto1.0 \
    libgcc \
    libstdc++ \
    ncurses-libs \
  && rm -rf /var/cache/apk/*
