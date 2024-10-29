#!/bin/bash

files=$(find $(pwd) -type f -name "*.sbatch")

for filename in $files
do
	cd $(dirname $filename)
	echo "sbatch $filename"
	sbatch $filename
done
