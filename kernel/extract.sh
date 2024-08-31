#!/bin/bash
set -x

HERE="$(pwd)"

dd if=KERNEL of=/tmp/initramfs.cpio.gz bs=128 skip=100597
cd /tmp
gunzip -c initramfs.cpio.gz > initramfs.cpio
cpio -it < initramfs.cpio > initramfs-list.txt
mkdir initramfs && cd initramfs
cpio -idmv < ../initramfs.cpio

rsync -av /tmp/initramfs $HERE/
