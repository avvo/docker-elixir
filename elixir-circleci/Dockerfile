FROM ubuntu:xenial

ENV \
  LC_ALL='en_US.UTF-8'\
  LC_CTYPE='en_US.UTF-8' \
  MIX_ENV='test' \
  TERM='xterm'

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
  && curl -o "/tmp/${ERLANG_PKG}" ${ERLANG_URL} \
  && dpkg -i "/tmp/${ERLANG_PKG}" \
  && apt-get update \
  && apt-get -y install \
    esl-erlang=1:19.3 \
    elixir=1.4.1-1 \
  && rm -rf /var/lib/apt/lists/*

RUN \
  mix local.hex --force \
  && mix local.rebar --force
