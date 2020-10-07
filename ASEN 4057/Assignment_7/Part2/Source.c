#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "Source.h"

/*#######################################################################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 2
# Created: April 8, 2019
#
# Compute applied heating at (x,y)
#
# Input: x position, y position, problem to be solved
# Output: applied heating
#
#######################################################################################*/
double Source(double x, double y, int problem_index){
    // Initialize output variable
    double f;
    // Conditionals to determine applied heat
    if(problem_index==1){
        f = 0;
    }
    else if(problem_index==2){
        f = 2*(y*(1-y)+x*(1-x));
    }
    else if(problem_index==3){
        f = exp(-50*sqrt(pow((x-.5),2)+pow((y-.5),2)));
    }
    else if(problem_index==4){
        if(x<.1){
            f = 1;
        }
        else{
            f = 0;
        }
    }
    else if(problem_index==5){
        if(x>.01 && x<.015 && y>.01 && y<.015){
            f = 1600000;
        }
        else{
            f = 0;
        }
        return f;
    }
}
