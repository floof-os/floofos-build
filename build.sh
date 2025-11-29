#!/bin/bash
set -e

# FloofOS - Fast Line-rate Offload On Fabric Operating System
# Copyright (C) 2025 FloofOS Networks <dev@floofos.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License.

IMAGE_NAME="floofos-builder"

docker build -t $IMAGE_NAME .

docker run --privileged --rm \
    -v "$(pwd):/build" \
    $IMAGE_NAME

# Rename ISO
VERSION="1.0"
ISO_NAME="FloofOS-${VERSION}.iso"

if [ -f live-image-amd64.hybrid.iso ]; then
    mv live-image-amd64.hybrid.iso "$ISO_NAME"
    echo "Build Complete: $ISO_NAME"
else
    echo "Error: ISO not found!"
    exit 1
fi
