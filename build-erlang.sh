#!/bin/bash

set -euox pipefail

erlang=$1
os_version=$2
os=fedora

tag=${erlang}-${os}-${os_version}

dockerfile="erlang-${os}.dockerfile"

docker build -t avvo/erlang:${tag} --build-arg ERLANG=${erlang} --build-arg OS_VERSION=${os_version} -f ${dockerfile} ./

echo ${tag}
