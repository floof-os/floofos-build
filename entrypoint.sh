#!/bin/bash
set -e

cd /build

lb clean --purge

lb config noauto \
    --distribution bookworm \
    --architectures amd64 \
    --archive-areas "main contrib non-free non-free-firmware" \
    --apt-recommends false \
    --apt-indices false \
    --bootappend-live "boot=live components quiet splash net.ifnames=0 biosdevname=0" \
    --debian-installer false \
    --iso-application "FloofOS" \
    --iso-preparer "FloofOS Networks" \
    --iso-publisher "https://floofos.io" \
    --iso-volume "FloofOS" \
    --image-name "floofos-core" \
    --mirror-bootstrap "http://deb.debian.org/debian/" \
    --mirror-chroot "http://deb.debian.org/debian/" \
    --mirror-chroot-security "http://security.debian.org/debian-security/" \
    --checksums sha256 \
    --linux-flavours amd64 \
    --system live \
    --mode debian \
    --memtest none \
    --win32-loader false \
    --binary-images iso-hybrid \
    --hdd-size 4096

lb build
