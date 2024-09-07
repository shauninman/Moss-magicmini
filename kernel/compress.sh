#!/bin/bash
set -x

HERE="$(pwd)"

rsync -av $HERE/initramfs/ /tmp/initramfs/

cd /tmp/initramfs
cat ../initramfs-list.txt | cpio -H newc -ov -R 0:0 | gzip -n9 > ../initramfs-mod.cpio.gz

cd $HERE
dd if=/tmp/initramfs-mod.cpio.gz of=KERNEL seek=12876416 oflag=seek_bytes bs=1M conv=notrunc
