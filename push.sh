#!/usr/bin/env bash
set -xe

IMAGE="avvo/$(basename $(dirname $(dirname $(pwd))))"
VERSION="$(basename $(dirname $(pwd)))"
BASE="$(basename $(pwd))"
TAG="${VERSION}-${BASE}"
LATEST_TAG="latest"

if [ -n "${1}" ]; then
  TAG="${TAG}-${1}"
fi

if [ "${IMAGE}" == "avvo/elixir-release" ]; then
  LATEST_TAG="${LATEST_TAG}-${VERSION}"
else
  LATEST_TAG="${LATEST_TAG}-${BASE}"
fi

docker build -t "${IMAGE}:${TAG}" -t "${IMAGE}:${LATEST_TAG}" .
docker push "${IMAGE}:${TAG}"
docker push "${IMAGE}:${LATEST_TAG}"
