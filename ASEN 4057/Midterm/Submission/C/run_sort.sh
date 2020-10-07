#!/bin/bash
# Unzip given material, sort using sort.c, rezip
# Define input
dirname=$1
# compile code
gcc -o sort sort.c
# unzip and run sort
tar xvzf Array.tar.gz
./sort 2 Array1.in
./sort 2 Array2.in
./sort 2 Array3.in
./sort 2 Array4.in
./sort 2 Array5.in
./sort 2 Array6.in

# zip outputs
mkdir Arrayout
mv Array1.out Arrayout
mv Array2.out Arrayout
mv Array3.out Arrayout
mv Array4.out Arrayout
mv Array5.out Arrayout
mv Array6.out Arrayout

tar -czvf Arrayout.tar.gz Arrayout
rm -rf Arrayout

