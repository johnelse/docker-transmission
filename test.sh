#!/bin/sh

set -eux

make

mkdir -p /tmp/transmission-downloads
mkdir -p /tmp/transmission-incomplete

CONTAINER=`./run.py --password abc123 \
    --downloads /tmp/transmission-downloads \
    --incomplete /tmp/transmission-incomplete`

docker stop $CONTAINER
docker rm $CONTAINER
