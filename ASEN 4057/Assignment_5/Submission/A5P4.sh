#!/bin/bash
# Problem 4
# Compute average grade from grade file 
fname=$1
#floc=~/Shared/Assignments/Assignment_5/Materials/Assignments
grade=$(grep ";" $fname | cut -f 2 -d ";")
sum=0
cnt=0
for item in $grade; do
	((sum+=$item))
	((cnt+=1))
done
#((avg=$sum/$cnt)) 
avg=$(bc <<< "scale=2; $sum/$cnt")
echo "Average grade is $avg"
