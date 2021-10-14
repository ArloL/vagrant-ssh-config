#!/bin/sh

set -o errexit
set -o nounset
set -o xtrace

docker compose up --detach

mutagen project start
