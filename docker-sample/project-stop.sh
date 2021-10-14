#!/bin/sh

set -o errexit
set -o nounset
set -o xtrace

mutagen project terminate || true
