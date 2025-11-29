#!/bin/bash
set -e

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
