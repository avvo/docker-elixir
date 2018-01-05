FROM ubuntu:xenial

ENV \
  HOME=/opt/app/ \
  LANG='C.UTF-8' \
  MIX_ENV='test' \
  TERM='xterm' \
  ELIXIR_VERSION='1.5.1-1' \
  ERLANG_OTP_VERSION='20.0'

WORKDIR /opt/app

RUN \
  set -xe \
  && ERLANG_PKG='erlang-solutions_1.0_all.deb' \
  && ERLANG_URL="https://packages.erlang-solutions.com/${ERLANG_PKG}" \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
    curl \
    git \
    openssh-client \
    build-essential \
    mysql-client \
    libmysqlclient-dev \
    postgresql-client \
  && curl -o "/tmp/${ERLANG_PKG}" ${ERLANG_URL} \
  && dpkg -i "/tmp/${ERLANG_PKG}" \
  && apt-get update \
  && apt-get -y install \
    "esl-erlang=1:${ERLANG_OTP_VERSION}" \
    "elixir=${ELIXIR_VERSION}" \
  && rm -rf /var/lib/apt/lists/* \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mkdir -p /root/.ssh \
  && ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts \
  && chmod 700 /root/.ssh \
  && chmod 600 /root/.ssh/known_hosts
