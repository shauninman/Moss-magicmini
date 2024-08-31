#!/bin/bash
set -x

HERE="$(pwd)"

find rootfs/ -name ".DS_Store" -delete
rsync -av rootfs/ /tmp/rootfs/

rm SYSTEM
mksquashfs /tmp/rootfs SYSTEM -comp lzo -b 131072 -noappend -no-exports -all-root -force-uid 0 -force-gid 0 -no-duplicates -always-use-fragments
