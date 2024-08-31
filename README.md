# MOSS for the MagicX XU Mini M

We don't have source for the MagicX XU Mini M but we can decompile and recompile its dtbs and unpack and repack its initramfs and rootfs. Our source is a bunch of binary blobs. As such this repo only includes scripts to extract and repack our minor changes. I started with the "open" (meaning rom-free) [stock TF1][0] but if you want to make edits you can pickup from the [latest MOSS release][1].

Unfortunately macOS doesn't like some of the nodes that get created when extracting a cpio or squashfs (eg. `/dev/console`) so this all needs to be run in a docker container like my [generic-handheld-docker][2] which has handy things like `device-tree-compiler` and `u-boot-tools` already installed.

[0]:https://archive.org/download/magic-x-xu-mini-m-open
[1]:https://github.com/shauninman/MOSS-magicmini/releases/latest
[2]:https://github.com/shauninman/generic-handheld-docker