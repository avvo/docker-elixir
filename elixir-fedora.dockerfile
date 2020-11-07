ARG ARCH
ARG OS_VERSION
ARG ERLANG

FROM fedora:${OS_VERSION} AS build

RUN dnf -y update && dnf -y install \
  wget \
  ca-certificates \
  unzip \
  make

ARG ELIXIR
ARG ERLANG_MAJOR

RUN wget -q -O elixir.zip "https://repo.hex.pm/builds/elixir/v${ELIXIR}-otp-${ERLANG_MAJOR}.zip" && unzip -d /ELIXIR elixir.zip
WORKDIR /ELIXIR
RUN make -o compile DESTDIR=/ELIXIR_LOCAL install

FROM avvo/erlang:${ERLANG}-fedora-${OS_VERSION} AS final

COPY --from=build /ELIXIR_LOCAL/usr/local /usr/local
