#!/bin/sh

set -e

export LANG=C

image=lpe12proto/lava-$(basename ${PWD}):debian
docker build --no-cache --tag=$image .
