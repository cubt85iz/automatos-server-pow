# Builds the image for the repository.
[linux]
build:
  #!/usr/bin/env bash
  
  set -euxo pipefail

  # Source .env file for variables
  . .env

  # Defaults for unspecified values.
  DEBUG=${DEBUG:-false}
  NVIDIA_TAG=${NVIDIA_TAG:-}
  KERNEL_FLAVOR=${KERNEL_FLAVOR:-}
  ROOT=${ROOT:-automatos-server}

  if [ -n "$CONFIG" ]; then
    podman build \
      -t automatos-server-$CONFIG:latest \
      --build-arg DEBUG="$DEBUG" \
      --build-arg CONFIG="$CONFIG" \
      --build-arg NVIDIA_TAG="$NVIDIA_TAG" \
      --build-arg KERNEL_FLAVOR="$KERNEL_FLAVOR" \
      --build-arg ROOT="$ROOT" \
      -f core/Containerfile \
      .
  else
    echo "ERROR: Value for CONFIG must be provided."
    exit 1
  fi

# Updates the submodule for automatos.
update:
  @git submodule update --remote core

