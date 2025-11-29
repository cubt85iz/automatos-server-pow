# Variables
config-file := ".config/pow"

# Builds the image for the repository.
[linux]
build:
  #!/usr/bin/env bash
  
  set -euxo pipefail

  # Gather arguments from configuration
  CONFIG=$(just get-argument CONFIG)
  DEBUG=$(just get-argument DEBUG)
  KERNEL_FLAVOR=$(just get-argument KERNEL_FLAVOR)
  NVIDIA_TAG=$(just get-argument NVIDIA_TAG)
  ROOT=$(just get-argument ROOT)

  # Defaults for unspecified values.
  DEBUG=${DEBUG:-false}
  NVIDIA_TAG=${NVIDIA_TAG:-}
  KERNEL_FLAVOR=${KERNEL_FLAVOR:-}
  ROOT=${ROOT:-automatos-server}

  if [ -n "$CONFIG" ]; then
    podman build \
      -t automatos-server-$CONFIG:latest \
      --build-arg CONFIG="$CONFIG" \
      --build-arg DEBUG="$DEBUG" \
      --build-arg KERNEL_FLAVOR="$KERNEL_FLAVOR" \
      --build-arg NVIDIA_TAG="$NVIDIA_TAG" \
      --build-arg ROOT="$ROOT" \
      -f core/Containerfile \
      .
  else
    echo "ERROR: Value for CONFIG must be provided."
    exit 1
  fi

# Gets specified variable from 
[linux]
[private]
get-argument name:
  #!/usr/bin/env bash

  set -euxo pipefail

  var_value=$(jq -r ".arguments.{{ name }} // empty" {{ config-file }})
  if [ -n "$var_value" ]; then
    echo "$var_value"
  fi

# Updates the submodule for automatos.
update:
  @git submodule update --remote core

