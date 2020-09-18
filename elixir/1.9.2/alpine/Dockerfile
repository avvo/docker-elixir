FROM avvo/erlang:22-alpine

# Adapted from:
#   https://github.com/c0b/docker-elixir/blob/master/1.9/Dockerfile

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.9.2" \
	LANG=C.UTF-8 \
  MIX_ENV='test'

RUN set -xe \
  && STARTING_DIR="$(pwd)" \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="02aaa3ffd21f9cf51aceb3aa5a5bc2c1e2636b1611867e44f19693dcf856e25c" \
	&& buildDeps=' \
		ca-certificates \
		curl \
		make \
	' \
	&& apk --no-cache upgrade \
	&& apk add --no-cache --virtual .build-deps $buildDeps \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean \
  && apk del .build-deps \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mkdir -p '/root/.ssh' \
  && apk add --no-cache openssh-client build-base npm git \
  && ssh-keyscan -t rsa github.com > '/root/.ssh/known_hosts' \
  && chmod 700 '/root/.ssh' \
  && chmod 600 '/root/.ssh/known_hosts'
