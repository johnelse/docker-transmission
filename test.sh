#!/bin/sh

set -eux

./build.sh

mkdir -p /tmp/transmission-downloads
mkdir -p /tmp/transmission-incomplete

./run.py --password abc123 \
    --downloads /tmp/transmission-downloads \
    --incomplete /tmp/transmission-incomplete

# sleep 10

## "docker stop" fails under travis at the moment
## see https://github.com/travis-ci/travis-ci/issues/4661
# docker stop transmission-container
# docker rm transmission-container
# docker rmi transmission
