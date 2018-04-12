FROM avvo/erlang:20-a

# For latest ERLANG_OTP_VERSION, see: https://packages.erlang-solutions.com/erlang/
# For latest NODE_VERSION, see: https://github.com/nodesource/distributions/tree/master/deb

ENV \
  ELIXIR_VERSION='v1.6.1' \
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
    build-essential \
    git \
    libmysqlclient-dev \
    postgresql-client \
    mysql-client \
    software-properties-common \
  && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
  && ELIXIR_DOWNLOAD_SHA256="91109a1774e9040fb10c1692c146c3e5a102e621e9c48196bfea7b828d54544c" \
  && curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
  && echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
  && mkdir -p /usr/local/src/elixir \
  && tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
  && rm elixir-src.tar.gz \
  && cd /usr/local/src/elixir \
  && make install clean \
  && cd $HOME \
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
