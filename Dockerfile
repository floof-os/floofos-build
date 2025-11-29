# FloofOS - Fast Line-rate Offload On Fabric Operating System
# Copyright (C) 2025 FloofOS Networks <dev@floofos.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License.

FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y \
    live-build \
    debootstrap \
    xorriso \
    isolinux \
    syslinux-common \
    squashfs-tools \
    grub-pc-bin \
    grub-efi-amd64-bin \
    mtools \
    dosfstools \
    git \
    ca-certificates \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
