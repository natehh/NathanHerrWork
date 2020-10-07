#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cblas.h>
#include <lapacke.h>
#include "Build_LHS.h"
#include "Build_RHS.h"
#include "Conductivity.h"
#include "Source.h"
#include "BC.h"
#include "Output.h"

/*#######################################################################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 2
# Created: April 16, 2019
#
# Imitate a given matlab code to solve steady heat equation
#
# Input: n_cell and problem_index (from command line)
# Output: Output file with naming convention heat_solution_n_cell_problem_index
#         with the values of the temperature fields at grid nodes
#
#######################################################################################*/

int main(int argc, char *argv[]){
    // Convert input args to integers
    int n_cells = atoi(argv[1]);
    int problem_index = atoi(argv[2]);

    // Set length for problem
    double L;
    if (problem_index == 1 || problem_index == 2 || problem_index == 3 || problem_index ==4){
        L = 1; //[m]
    }
    else if (problem_index == 5){
        L = .025; // [m]
    }
    // define mesh size, nodes per side
    double h = L/n_cells;
    int nodes_per_side = n_cells + 1;

    // allocate and build x and y position matrices
    double *x_array, *y_array;
    x_array = (double*)malloc(nodes_per_side*sizeof(double));
    y_array = (double*)malloc(nodes_per_side*sizeof(double));

    for(int i=0; i<nodes_per_side; i++){
        x_array[i] = i*h;
        y_array[i] = i*h;
    }

    // create matrix to hold indeces
    double **index = (double**)calloc(nodes_per_side, sizeof(double*));
    index[0] = (double*)calloc(nodes_per_side*nodes_per_side, sizeof(double));
    for(int i=1; i<nodes_per_side; i++){
        index[i] = index[i-1]+nodes_per_side;
    }

    // fill index matrix
    for (int i=0; i<nodes_per_side; i++){
        for(int j=0; j<nodes_per_side; j++){
            index[i][j] = i*nodes_per_side+j;
        }
    }
    // Build K and F matrices
    int matsize;
    //double **K, **F;
    matsize = pow(nodes_per_side,2);
    double **K = (double**)calloc(matsize, sizeof(double*));
    K[0] = (double*)calloc(matsize*matsize, sizeof(double));
    for(int i=1; i<matsize; i++){
        K[i] = K[i-1]+matsize;
    }

    double **F = (double**)calloc(matsize, sizeof(double*));
    F[0] = (double*)calloc(matsize*1, sizeof(double));
    for(int i=1; i<matsize; i++){
        F[i] = F[i-1]+1;
    }

    // Perform the interior assembly
    Build_LHS(K, n_cells, x_array, y_array, index, h, problem_index);
    Build_RHS(F, n_cells, x_array, y_array, index, h, problem_index);

    // Solution vector d

    double *F_n = (double*)malloc(matsize*sizeof(double));

    for (int i=0; i<matsize; i++){
        F_n[i] = F[i][0];
    }

    // compute d with lapack
    lapack_int out, n, nrhs, lda, ldb;
    lapack_int ipiv[n];
    n = matsize;
    nrhs = 1;
    lda = matsize;
    ldb = 1;

    out = LAPACKE_dgesv(LAPACK_ROW_MAJOR, n, nrhs, *K, lda, ipiv, F_n, ldb);

    Output(n_cells, problem_index, F_n, x_array, y_array, nodes_per_side, index);

    //free memory
    free(F_n); free(F); free(K); free(index); free(x_array); free(y_array);

    return 0;
}
