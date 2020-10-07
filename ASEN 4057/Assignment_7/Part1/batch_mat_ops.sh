#!/bin/bash
# Nathan Herr
# April 8, 2019
# ASEN 4057
# Assignment 7 Part 1.2

# Test all possible combinations of the 3 matrices
# Copy needed files to the input directory
#cp mat_ops.c $1
#cp mat_ops.h $1
cd $1
gcc -o mat_ops mat_ops.c -lblas -lgfortran

echo "Check all possible combinations"
./mat_ops A B C
./mat_ops B A C
./mat_ops B C A
./mat_ops C B A
./mat_ops C A B
./mat_ops A C B

