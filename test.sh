#!/bin/sh

set -eux

PASSWORD=abc123

make

mkdir -p /tmp/transmission-downloads
mkdir -p /tmp/transmission-incomplete

CONTAINER=`./run.py --password $PASSWORD \
    --downloads /tmp/transmission-downloads \
    --incomplete /tmp/transmission-incomplete`

wget --http-user=transmission --http-password=$PASSWORD 127.0.0.1:9091

docker stop $CONTAINER
docker rm $CONTAINER
