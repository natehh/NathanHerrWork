#!/bin/bash
#########################################
# Nathan Herr
# ASEN 4057: Assignment 6
# Bash script to Run given set of clearances
#########################################

# create for loop to run through all given clearance values for objective 1
for clearance in 0 10 100 1000 5000 10000 50000 100000; do
	# Declare, compile, and run each instance
	echo "Calculate Objective 1 with clearance of $clearance m..."
	gcc -o ThreeBody A6_main.c -lm
	./ThreeBody 1 $clearance .5
done


# repeat process for objective 2
for clearance in 0 10 100 1000 5000 10000 50000 100000; do
        # Declare, compile, and run each instance
        echo "Calculate Objective 2 with clearance of $clearance m..."
        gcc -o ThreeBody A6_main.c -lm
        ./ThreeBody 2 $clearance .5
done
