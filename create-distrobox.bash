#!/usr/bin/env bash
set -euo pipefail

image=ghcr.io/comminutus/base-shell-env
: "${TAG:=latest}"
name=base


distrobox rm --force "$name"
distrobox create -p -i "$image:$TAG" "$name"
distrobox enter --name "$name"
