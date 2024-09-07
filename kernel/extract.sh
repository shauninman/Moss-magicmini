#!/bin/bash
set -x

HERE="$(pwd)"

dd if=KERNEL of=/tmp/initramfs.cpio.gz skip=12876416 iflag=skip_bytes bs=1M
cd /tmp
gunzip -c initramfs.cpio.gz > initramfs.cpio
cpio -it < initramfs.cpio > initramfs-list.txt
mkdir initramfs && cd initramfs
cpio -idmv < ../initramfs.cpio

rsync -av /tmp/initramfs $HERE/
