FROM ubuntu:xenial

ENV \
  HOME=/opt/app/ \
  LANG='C.UTF-8' \
  MIX_ENV='prod' \
  TERM='xterm'

WORKDIR /opt/app

RUN \
  set -xe \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install openssl wget mysql-client \
  && rm -rf /var/lib/apt/lists/*
