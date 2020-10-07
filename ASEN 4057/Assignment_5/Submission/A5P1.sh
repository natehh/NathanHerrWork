#!/bin/bash
# Assignment 5 problem 1
# Write script to count between integer inputs
a=$1
b=$2
counter=$a
while [ $counter -lt $b ]; do
	echo $counter
	((counter+=1))
done
echo $b
