#!/bin/bash

set -euox pipefail

elixir=$1
erlang=$2
os_version=$3
os=fedora

tag=${elixir}-erlang-${erlang}-${os}-${os_version}
erlang_major=$(echo "${erlang}" | awk 'match($0, /^[0-9][0-9]/) { print substr( $0, RSTART, RLENGTH )}')

dockerfile="elixir-${os}.dockerfile"

docker build -t avvo/elixir:${tag} --build-arg ELIXIR=${elixir} --build-arg ERLANG=${erlang} --build-arg ERLANG_MAJOR=${erlang_major} --build-arg OS_VERSION=${os_version} -f ${dockerfile} ./

echo ${tag}
