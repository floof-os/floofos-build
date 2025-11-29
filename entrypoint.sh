#!/bin/bash
set -e

cd /build

lb clean

lb config

lb build
