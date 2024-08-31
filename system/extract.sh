#!/bin/bash
set -x

HERE="$(pwd)"

unsquashfs -d /tmp/rootfs SYSTEM
rsync -av /tmp/rootfs $HERE/