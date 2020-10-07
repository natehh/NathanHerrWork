#include <stdio.h>
#include <stdlib.h>
#include "Conductivity.h"

/*#######################################################################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 2
# Created: April 8, 2019
#
# Find Conductivity at (x,y)
#
# Input: x position, y position, problem to be solved
# Output: conductivity at position
#
#######################################################################################*/
double Conductivity(double x, double y, int problem_index){
    double k;

    // Conditionals to determine which conductivity to assign
    if(problem_index==1 || problem_index==2 || problem_index==3){
        k = 1;
    }
    else if(problem_index==4){
        if(x>.5){
            k = 20;
        }
        else{
            k = 1;
        }
    }
    else if(problem_index==5){
        if(x>.01 && x<.15 && y>.01 && y<.015){
            k = 167;
        }
        else{
            k = 157;
        }
    }
    return k;
}
