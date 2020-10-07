#include <stdio.h>
#include <stdlib.h>
#include "Output.h"

/*#######################################################################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 2
# Created: April 8, 2019
#
# Output file writer
#
# Input: number of cells per side, arrays of x and y positions, index, nodes per side,
#
# Output: Output file
#
#######################################################################################*/
void Output(int n_cell, int problem_index, double* F_n, double* x_array,
            double* y_array, int nodes_per_side, double** index){
    // Initialize file name with plenty of room for naming convention
    char fname[25];
    sprintf(fname, "heat_solution_%d_%d",n_cell, problem_index);

    // Open file
    FILE *ftag = fopen(fname, "w");

    int tempindex;
    // Populate Output file
    for(int i=0; i<nodes_per_side; i++){
        for(int j=0; j<nodes_per_side; j++){
            fprintf(ftag, "%f ", x_array[i]);
            fprintf(ftag, "%f ", y_array[j]);
            tempindex = index[i][j];
            fprintf(ftag, "%f \n", F_n[tempindex]);
        }
    }
    fclose(ftag);
}
