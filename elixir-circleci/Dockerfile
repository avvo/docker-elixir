FROM ubuntu:xenial

ENV \
  ELIXIR_VERSION='1.5.2-1' \
  ERLANG_OTP_VERSION='20.1' \
  HOME='/opt/app/' \
  LANG='C.UTF-8' \
  MIX_ENV='test' \
  NODE_VERSION='8' \
  TERM='xterm'

WORKDIR "${HOME}"

RUN \
  set -xe \
  && ERLANG_PKG='erlang-solutions_1.0_all.deb' \
  && ERLANG_URL="https://packages.erlang-solutions.com/${ERLANG_PKG}" \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
    curl \
    wget \
  && curl -o "/tmp/${ERLANG_PKG}" ${ERLANG_URL} \
  && dpkg -i "/tmp/${ERLANG_PKG}" \
  && wget -qO- "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | bash - \
  && apt-get update \
  && apt-get -y install \
    "elixir=${ELIXIR_VERSION}" \
    "esl-erlang=1:${ERLANG_OTP_VERSION}" \
    apt-transport-https \
    build-essential \
    ca-certificates \
    git \
    libmysqlclient-dev \
    mysql-client \
    nodejs \
    openssh-client \
    software-properties-common \
  && rm -rf '/var/lib/apt/lists/*' \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mkdir -p '/root/.ssh' \
  && ssh-keyscan -t rsa github.com > '/root/.ssh/known_hosts' \
  && chmod 700 '/root/.ssh' \
  && chmod 600 '/root/.ssh/known_hosts'
