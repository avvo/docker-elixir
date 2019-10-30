#!/usr/bin/env bash
set -xe

IMAGE="avvo/$(basename $(dirname $(dirname $(pwd))))"
VERSION="$(basename $(dirname $(pwd)))"
BASE="$(basename $(pwd))"
TAG="${VERSION}-${BASE}"
if [ -n "${1}" ]; then
  TAG="${TAG}-${1}"
fi

docker build -t "${IMAGE}:${TAG}" -t "${IMAGE}:latest-${BASE}" .
# docker push "${IMAGE}:${TAG}"
# docker push "${IMAGE}:latest-${BASE}"
