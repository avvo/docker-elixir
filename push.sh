#!/bin/bash

for i in "$@"
do
case $i in
    --elixir=*)
    elixir="${i#*=}"
    shift
    ;;
    --otp=*|--erlang=*)
    erlang="${i#*=}"
    shift
    ;;
    --os-version=*)
    os_version="${i#*=}"
    shift
    ;;
esac
done

erlang_image_tag=$(./build-erlang.sh ${erlang} ${os_version})
elixir_image_tag=$(./build-elixir.sh ${elixir} ${erlang} ${os_version})

try_to_push() {
  image=$1

  # This command have a tendancy to intermittently fail
  docker push ${image} ||
    (sleep $((20 + $RANDOM % 40)) && docker push ${image}) ||
    (sleep $((20 + $RANDOM % 40)) && docker push ${image}) ||
    (sleep $((20 + $RANDOM % 40)) && docker push ${image}) ||
    (sleep $((20 + $RANDOM % 40)) && docker push ${image}) ||
    (exit 0)
}

try_to_push avvo/erlang:${erlang_image_tag}
try_to_push avvo/elixir:${elixir_image_tag}
