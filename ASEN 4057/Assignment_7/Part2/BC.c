#include <stdio.h>
#include <stdlib.h>
#include "BC.h"

/*#######################################################################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 2
# Created: April 8, 2019
#
# Compute boundary temperature field at (x,y)
#
# Input: x position, y position, problem to be solved
# Output: Boundary temperature field
#
#######################################################################################*/
double BC(double x, double y, int problem_index){
    double g;
    // Conditionals to set boundary temperaure
    if(problem_index==1){
        g = x;
    }
    else if(problem_index==2 || problem_index==3 || problem_index==4){
        g = 0;
    }
    else if(problem_index==5){
        g = 343.15;
    }
    return g;
}
