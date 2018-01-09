# Elixir Docker images from Avvo

These Dockerfiles are used to build docker images we use for various Elixir
containers at Avvo.

## Development

1. Clone this repo
2. Edit the Dockerfile you want to update
3. Keep the primary version number of the image in sync with the Elixir version. So tag '1.5.1'
   should be Elixir version 1.5.1. Any changes to the dockerfile that are not elixir version
   related should increase the letter version.
4. Build and push an image with a version tag:
```
cd elixir-circleci
../push.sh '1.5.2-1c'
```

Two notes:

a. You need permissions to write the images on dockerhub. If you're not an 
Avvo person, you probably don't have access. You can push it up to your own 
namespace.

b. Test out your changes on a tag before committing and pushing to latest.

## License

MIT Licence. Do what you want, this is just configuration, nothing special.
