#!/usr/bin/env bash
set -euv

# ${1} for node version
# ${2} for npm command

docker run \
       --rm \
       --volume "$(pwd):/app" \
       --workdir "/app" \
       --entrypoint /bin/sh \
       node:${1}-slim -c "${2}"
