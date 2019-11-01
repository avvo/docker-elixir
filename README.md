# Elixir Docker images from Avvo

These Dockerfiles are used to build docker images we use for various
[Elixir](https://hub.docker.com/r/avvo/elixir/tags/) and
[Erlang](https://hub.docker.com/r/avvo/erlang/tags/) containers at Avvo.

## Development

1. Clone this repo
2. Edit the Dockerfile you want to update
3. Keep the primary version number of the image in sync with the Elixir version and its base erlang/otp version.
   So tag '1.6.2' should be Elixir version 1.6.2. Any changes to the Dockerfile
   that are not Elixir version or base image version related should increase the letter version.
4. Build and push an image with a version tag

Calling `push.sh` with no argument will use the directory name as the tag. For
example, the following command will push an `erlang` image with the tags
`22.1.3-alpine` and `alpine-latest` to Dockerhub:

```
cd erlang/22.1.3/alpine
../../../push.sh
```

If an argument is passed to `push.sh`, it will be used as a suffix appended with
a `-` to the current directory name. For example, the following command will
push an `elixir` image with the tags `1.9.2-alpine-otp22` and `alpine-latest` to Dockerhub:

```
cd elixir/1.9.2/alpine
../../../push.sh otp22
```

#### Notes

1. You need permissions to write the images on dockerhub. If you're not an Avvo
   person, you probably don't have access. You can push it up to your own
   namespace.
2. Test out your changes on a tag before committing and pushing to latest.

## Multistage Docker Build for Production

Lower final image size by using multistage docker build and avvo/alpine image.

```Dockerfile
FROM avvo/elixir:1.9.2-alpine-otp22 AS build

ENV MIX_ENV=prod

COPY . .

RUN mix do deps.get, deps.compile, compile

# If you have assets to build
RUN cd assets \
  && npm install \
  && npm run deploy \
  && cd ..

RUN mix phx.digest

RUN mix release

FROM avvo/elixir-release:alpine-3.9

EXPOSE 4000

WORKDIR /srv/app_name

COPY --from=build ./_build/prod/rel/app_name/ .

ENTRYPOINT ["avvoenv", "exec"]
CMD ["bin/app_name", "start"]
```

## License

MIT Licence. Do what you want, this is just configuration, nothing special.
