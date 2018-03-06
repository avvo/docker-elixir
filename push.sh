#!/usr/bin/env bash
set -e

VERSION=$1
if [ -z "${VERSION}" ]; then
  echo "Please provide a Docker image version tag"
  exit 1
fi

set -x

IMAGE="avvo/$(basename $(pwd))"

docker build -t "${IMAGE}:${VERSION}" -t "${IMAGE}:latest" .
docker push "${IMAGE}:${VERSION}"
docker push "${IMAGE}:latest"
