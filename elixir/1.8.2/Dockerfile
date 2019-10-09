FROM avvo/erlang:22.0.7

# Adapted from:
#   https://github.com/c0b/docker-elixir/blob/master/1.8/Dockerfile
#
# For latest NODE_VERSION, see: https://github.com/nodesource/distributions/tree/master/deb

ENV ELIXIR_VERSION="v1.8.2" \
	LANG=C.UTF-8

ENV \
  ELIXIR_VERSION='v1.8.2' \
  ELIXIR_DOWNLOAD_SHA256="cf9bf0b2d92bc4671431e3fe1d1b0a0e5125f1a942cc4fdf7914b74f04efb835" \
  NODE_VERSION='10' \
  HOME='/opt/app/' \
  LANG='C.UTF-8' \
  MIX_ENV='test' \
  TERM='xterm'

WORKDIR "${HOME}"

RUN \
  set -xe \
  && apt-get update -qq \
  && apt-get upgrade -y \
  && apt-get install -y \
    build-essential \
    git \
    libmysqlclient-dev \
    postgresql-client \
    mysql-client \
    software-properties-common \
  && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
  && curl -fSL -o elixir-src.tar.gz "${ELIXIR_DOWNLOAD_URL}" \
  && echo "${ELIXIR_DOWNLOAD_SHA256}  elixir-src.tar.gz" | sha256sum -c - \
  && mkdir -p /usr/local/src/elixir \
  && tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
  && rm elixir-src.tar.gz \
  && cd /usr/local/src/elixir \
  && make install clean \
  && cd "${HOME}" \
  && curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | bash - \
  && apt-get update -qq \
  && apt-get upgrade -y \
  && apt-get install -y \
    nodejs \
  && rm -rf '/var/lib/apt/lists/*' \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mkdir -p '/root/.ssh' \
  && ssh-keyscan -t rsa github.com > '/root/.ssh/known_hosts' \
  && chmod 700 '/root/.ssh' \
  && chmod 600 '/root/.ssh/known_hosts'
