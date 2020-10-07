#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "Build_RHS.h"
#include "Source.h"
#include "BC.h"

/*#######################################################################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 2
# Created: April 8, 2019
#
# Construct RHS matrix
#
# Input: matrix name to be filled in, number of cells per side, array of x positions,
#        array of y positions, index, mesh size, problem index
# Output: Matrix
#
#######################################################################################*/
void Build_RHS(double** F, int n_cells, double* x_array, double* y_array,
                double **index, double h, int problem_index){
    // initialize variables from given matlab code
    int i, j, index_center, index_bottom, index_top, index_left, index_right,
    i_left, i_right, j_top, j_bottom, nodes_per_side;
    double x, y, x_left, x_right, y_top, y_bottom, kappa_bottom, kappa_top,
    kappa_left, kappa_right;
    nodes_per_side = n_cells+1;

    for(i=1; i<n_cells; i++){
        for(j=1; j<n_cells; j++){
            // Determine position of center
			x = x_array[i];
			y = y_array[j];

			// Determine the indices associated with the five point stencil
			index_center = index[i][j];

			// Determine contributions to RHS matrix
			F[index_center][0] = Source(x,y,problem_index);
        }
    }

    // Boundary Assembly, Right of RHS
    for(j=0; j<nodes_per_side; j++){
        // Determine position
        x_left = x_array[0];
        x_right = x_array[nodes_per_side-1];

        // Determine the i indices
        i_left = 0;
        i_right = nodes_per_side-1;

        // Determine the position indices
        index_left = index[i_left][j];
        index_right = index[i_right][j];

        // Set RHS according to BC
        F[index_left][0] = BC(x_left,y,problem_index);
        F[index_right][0] = BC(x_right,y,problem_index);
    }

    // Boundary assembly, Bottom and Top sides:
    for(i=0; i<nodes_per_side; i++){
        // Determine position
        x_left = x_array[0];
        x_right = x_array[nodes_per_side-1];

        // Determine the i indices
        i_left = 0;
        i_right = nodes_per_side-1;

        // Determine the position indices
        index_left = index[i_left][j];
        index_right = index[i_right][j];

        // Set RHS according to BC
        F[index_left][0]  = BC(x_left,y,problem_index);
        F[index_right][0] = BC(x_right,y,problem_index);
    }
}
