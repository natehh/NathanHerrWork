#!/bin/bash
# Problem 3
# rename all files with particular extension in a directory
name=$1
ext=$2
picnum=1
picloc=Pictures
for file in $picloc/*jpg ; do
	cp $file $name$picnum.$ext
	((picnum+=1))
done
