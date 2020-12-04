# Elixir Docker images from Avvo

These Dockerfiles are used to build docker images we use for various
[Elixir](https://hub.docker.com/r/avvo/elixir/tags/) and
[Erlang](https://hub.docker.com/r/avvo/erlang/tags/) containers at Avvo.

These scripts are only to build erlang and elixir images based on Fedora.
For alpine/ubuntu/debian, please consider [images built by Bob](https://github.com/hexpm/bob#docker-images).

## Build an image

1. Clone this repo
2. Run `./push.sh` providing `ELIXIR_VERSION`, `ERLANG_VERSION` and `OS_VERSION` as argiments.

For example:
```bash
./push.sh --elixir=1.11.2 --erlang=23.1.2 --os-version=32
```
will build and push to 2 images:
 - `avvo/eralng:23.1.2-fedora-32`
 - `avvo/elixir:1.11.2-erlang-23.1.2-fedora-32`

#### Notes

1. You need permissions to write the images on dockerhub. If you're not an Avvo
   person, you probably don't have access. You can push it up to your own
   namespace.
2. Test out your changes on a tag before committing and pushing to latest.

## Multistage Docker Build for Production

Lower final image size by using multistage docker build and fedora image.

```Dockerfile
FROM avvo/elixir:1.11.2-erlang-23.1.2-fedora-32 as build

# install build dependencies
RUN dnf -y update && dnf -y install \
    make automake gcc gcc-c++ kernel-devel \
    git

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /srv

COPY . .

ENV MIX_ENV=prod

RUN mix do deps.get --only prod, deps.compile
RUN mix do compile, release

FROM fedora:32

ENV LANG=C.UTF-8

RUN set -xe \
  && dnf -y update \
  && dnf -y install \
    ncurses-libs \
    openssl \
  && dnf -y clean all \
  && rm -rf /var/cache/yum

EXPOSE 4000

WORKDIR /srv/app_name

COPY --from=build ./srv/_build/prod/rel/app_name .

CMD ["bin/app_name", "start"]
```

## License

MIT Licence. Do what you want, this is just configuration, nothing special.
