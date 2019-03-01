#!/bin/sh

set -e

export LANG=C

image=lpe12proto/lava-$(basename ${PWD}):alpine
docker build --no-cache --pull --tag=$image .
