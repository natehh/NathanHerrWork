#!/bin/bash
# Script to execute Problem 2
# take file/directory and report if file is directory, regular file, or other
# report permissions for user on file/directory

infile=$1
perm=$(ls -l $infile | head -c 4)

if [ -f $infile ]
then 
	echo "$infile is a file with user permissions $perm"
fi
if [ -d $infile ]
then 
	echo "$infile is a directory with user permissions $perm"
fi

