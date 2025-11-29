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
