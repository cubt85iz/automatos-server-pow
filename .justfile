# Builds the image for the repository.
[linux]
build:
  #!/usr/bin/env bash

  set -euxo pipefail

  BASE_TAG="stable-nvidia-zfs"
  CONFIG="pow"
  ROOT="core"

  podman build \
    -t automatos-server-$CONFIG:latest \
    --build-arg BASE_TAG="$BASE_TAG" \
    --build-arg CONFIG="$CONFIG" \
    --build-arg ROOT="$ROOT" \
    -f core/Containerfile \
    .

# Updates the submodule for automatos.
update:
  @git submodule update --remote core

