#!/bin/bash
set -x

shopt -s nullglob  # Ensure that the loop doesn't run if no files match
for FILE in *.dts; do
	NAME="${FILE%.*}"
	dtc -I dts -O dtb -o $NAME.dtb $NAME.dts 2> >(grep -v "Warning")
done
