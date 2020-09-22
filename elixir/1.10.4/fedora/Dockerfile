FROM avvo/erlang:23.0.4-fedora-32

# Adapted from:
#   https://github.com/c0b/docker-elixir/blob/master/1.10/alpine/Dockerfile

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.10.4" \
	LANG=C.UTF-8

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="8518c78f43fe36315dbe0d623823c2c1b7a025c114f3f4adbb48e04ef63f1d9f" \
	&& deps=' \
		ca-certificates \
    make \
    automake \
    gcc \
    gcc-c++ \
    kernel-devel \
    openssh-clients \
    npm \
    git \
	' \
  && dnf -y update \
  && dnf -y install $deps \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean \
  && dnf -y autoremove \
	&& dnf -y clean all \
  && rm -rf /var/cache/yum \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mkdir -p '/root/.ssh' \
  && ssh-keyscan -t rsa github.com > '/root/.ssh/known_hosts' \
  && chmod 700 '/root/.ssh' \
  && chmod 600 '/root/.ssh/known_hosts'
