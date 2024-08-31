#!/bin/bash
set -x

shopt -s nullglob  # Ensure that the loop doesn't run if no files match
for FILE in *.dtb; do
	NAME="${FILE%.*}"
	dtc -I dtb -O dts -o $NAME.dts $NAME.dtb 2> >(grep -v "Warning")
done
