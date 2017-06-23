FROM alpine:3.6

RUN \
  set -xe \
  && apk update \
  && apk upgrade \
  && apk --no-cache --update add \
    libcrypto1.0 \
    libgcc \
    libstdc++ \
    ncurses-libs \
  && rm -rf /var/cache/apk/*
