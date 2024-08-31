#!/bin/bash
set -x

# based on https://github.com/AmberELEC/AmberELEC/blob/dev/scripts/mkimage

HERE=$(dirname "$0")
cd "$HERE"

SYSTEM_PART_START=32768
SYSTEM_SIZE=368
IMAGE_NAME=MOSS
UUID_SYSTEM=0508-2833

DISK_START_PADDING=$(( (${SYSTEM_PART_START} + 2048 - 1) / 2048 ))
DISK_GPT_PADDING=1
DISK_SIZE=$(( ${DISK_START_PADDING} + ${SYSTEM_SIZE} + ${DISK_GPT_PADDING} ))

DISK_BASENAME="${HERE}/${IMAGE_NAME}"
DISK="${DISK_BASENAME}.img"
rm "$DISK"

LE_TMP=$(mktemp -d)

# create image
dd if=/dev/zero of="${DISK}" bs=1M count="${DISK_SIZE}" conv=fsync
sync

# set label
parted -s "${DISK}" mklabel msdos
sync

# create part 1
SYSTEM_PART_END=$(( ${SYSTEM_PART_START} + (${SYSTEM_SIZE} * 1024 * 1024 / 512) - 1 ))
parted -s "${DISK}" -a min unit s mkpart primary fat32 ${SYSTEM_PART_START} ${SYSTEM_PART_END}
parted -s "${DISK}" set 1 boot on

# create fs on part 1
OFFSET=$(( ${SYSTEM_PART_START} * 512 ))
HEADS=4
TRACKS=32
SECTORS=$(( ${SYSTEM_SIZE} * 1024 * 1024 / 512 / ${HEADS} / ${TRACKS} ))

shopt -s expand_aliases  # enables alias expansion in script
alias mformat="mformat -i ${DISK}@@${OFFSET} -h ${HEADS} -t ${TRACKS} -s ${SECTORS}"
alias mcopy="mcopy -i ${DISK}@@${OFFSET}"
alias mmd="mmd -i ${DISK}@@${OFFSET}"

mformat -v "${IMAGE_NAME}" -N "${UUID_SYSTEM//-/}" ::
sync

# add dtb/KERNEL/SYSTEM/et al
mcopy res/* ::
mcopy ../dtb/*.dtb ::
mcopy ../kernel/KERNEL ::
mcopy ../system/SYSTEM ::
sync

dd if=pre.img of=${DISK} bs=1024 seek=32 conv=fsync,notrunc
# gzip -k ${DISK}
zip ${DISK}.zip ${DISK}
