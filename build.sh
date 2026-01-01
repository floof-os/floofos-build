#!/bin/bash
set -e

# FloofOS - Fast Line-rate Offload On Fabric Operating System
# Copyright (C) 2025 FloofOS Networks <dev@floofos.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License.

IMAGE_NAME="floofos-builder"

echo "Cleaning previous build"
rm -rf .build auto/config.build binary binary.* cache chroot chroot.* config/binary config/bootstrap config/chroot config/common config/source .stage live-image* *.iso *.img *.list *.packages 2>/dev/null || true

echo "Making auto/config executable"
chmod +x auto/config

echo "Building Docker image"
docker build --no-cache -t $IMAGE_NAME .

echo "Running build in Docker"
docker run --privileged --rm \
    -v "$(pwd):/build" \
    $IMAGE_NAME

VERSION="1.0"
ARCH="amd64"
ISO_NAME="FloofOS-${VERSION}-${ARCH}.iso"

if [ -f floofos-core-amd64.hybrid.iso ]; then
    mv floofos-core-amd64.hybrid.iso "$ISO_NAME"
    echo "Generating checksums..."
    sha256sum "$ISO_NAME" > "${ISO_NAME}.sha256"
    md5sum "$ISO_NAME" > "${ISO_NAME}.md5"
    echo ""
    echo "Build Complete!"
    echo "  ISO:      $ISO_NAME"
    echo "  Size:     $(du -h "$ISO_NAME" | cut -f1)"
    echo "  SHA256:   $(cat "${ISO_NAME}.sha256" | cut -d' ' -f1)"
    echo "  MD5:      $(cat "${ISO_NAME}.md5" | cut -d' ' -f1)"
    echo ""
else
    echo "Error: ISO not found!"
    exit 1
fi
