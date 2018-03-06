#!/usr/bin/env bash
set -xe

IMAGE="avvo/$(basename $(dirname $(pwd)))"
TAG="$(basename $(pwd))"
if [ -n "${1}" ]; then
  TAG="${TAG}-${1}"
fi

docker build -t "${IMAGE}:${TAG}" -t "${IMAGE}:latest" .
#docker push "${IMAGE}:${TAG}"
#docker push "${IMAGE}:latest"
