FROM ubuntu:xenial

# For latest ERLANG_OTP_VERSION, see: https://packages.erlang-solutions.com/erlang/
# For latest NODE_VERSION, see: https://github.com/nodesource/distributions/tree/master/deb

ENV \
  ELIXIR_VERSION='1.5.2-1' \
  ERLANG_OTP_VERSION='20.1.7' \
  HOME='/opt/app/' \
  LANG='C.UTF-8' \
  MIX_ENV='test' \
  NODE_VERSION='8' \
  TERM='xterm'

WORKDIR "${HOME}"

RUN \
  set -xe \
  && apt-get update -qq \
  && apt-get upgrade -y \
  && apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    libmysqlclient-dev \
    mysql-client \
    openssh-client \
    software-properties-common \
  && curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | bash - \
  && ERLANG_PKG='erlang-solutions_1.0_all.deb' \
  && ERLANG_URL="https://packages.erlang-solutions.com/${ERLANG_PKG}" \
  && curl -o "/tmp/${ERLANG_PKG}" ${ERLANG_URL} \
  && dpkg -i "/tmp/${ERLANG_PKG}" \
  && apt-get update -qq \
  && apt-get upgrade -y \
  && apt-get install -y \
    nodejs \
    "elixir=${ELIXIR_VERSION}" \
    "esl-erlang=1:${ERLANG_OTP_VERSION}" \
  && rm -rf '/var/lib/apt/lists/*' \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mkdir -p '/root/.ssh' \
  && ssh-keyscan -t rsa github.com > '/root/.ssh/known_hosts' \
  && chmod 700 '/root/.ssh' \
  && chmod 600 '/root/.ssh/known_hosts'
