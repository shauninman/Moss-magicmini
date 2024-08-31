#!/bin/bash
set -x

# pre.img was originally copied directly from stock TF1
# but an existing MOSS.img can also be used in a pinch
dd if=MagicX_XU_MINI_M_Open.img of=pre.img bs=1024 skip=32 count=16352
