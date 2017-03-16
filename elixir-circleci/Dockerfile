FROM ubuntu:xenial

ENV TERM=xterm \
  MIX_ENV=test \
  LANG=en_US.UTF-8 \
  LC_CTYPE=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install curl git openssh-client \
  && curl -o /tmp/erlang-solutions_1.0_all.deb \
     https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i /tmp/erlang-solutions_1.0_all.deb \
  && apt-get update \
  && apt-get -y install esl-erlang=1:19.3 elixir=1.4.1-1 \
  && rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force && mix local.rebar --force
