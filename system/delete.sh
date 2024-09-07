#!/bin/bash
set -x

if [[ "$1" == rootfs* ]]; then
	rm -rf "$1"
	rm -rf "/tmp/$1"
fi