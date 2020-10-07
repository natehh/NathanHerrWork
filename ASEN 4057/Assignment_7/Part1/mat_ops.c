#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cblas.h>
#include "mat_ops.h"

/*#####################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 1
# Created: April 1, 2019
#
# Build and fill 2D matrix dynamically
#
# Input: matrix dimensions
# Output: Matrix
#
#########################################*/
double **createmat(int row, int col){
    // initialize matrix
    double **mat = (double**)calloc(row, sizeof(double*));
    mat[0] = (double*)calloc(row*col, sizeof(double));

    // for loop to build the matrix of the proper size
    for(int i=1; i<row; i++){
        mat[i] = mat[i-1]+col;
    }
    return mat;
}

/*#####################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 1
# Created: April 1, 2019
#
# Read input file to fill matrix
#
# Input: File name
# Output: 2D array containing the matrix from the file
#
#########################################*/
double **readfile(char *fname){
    // set variables for dimensions
    int dim[2];
    int xdim;

    //read file
    FILE *matfile;
    matfile = fopen(fname, "r");

    // check for error
    if (matfile==NULL){
        printf("Error: File not found\n");
    }

    // search files for dimensions
    fscanf(matfile, "%d", &xdim);
    dim[0] = xdim;
    fscanf(matfile, "%d", &xdim);
    dim[1] = xdim;

    // call createmat to create a matrix with the given dimensions
    double **mat;
    double matval;
    mat = createmat(dim[0],dim[1]);

    // fill array with values from file using for loop
    for(int i=0; i<dim[0]; i++){
        for(int j=0; j<dim[1]; j++){
            fscanf(matfile, "%lf", &matval);
            mat[i][j] = matval;
        }
    }
    fclose(matfile);
    return mat;
}
/*#####################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 1
# Created: April 1, 2019
#
# Write matrix to ouput file
#
# Input: Dimensions, matrix, filename
# Output: File contraining matrix
#
#########################################*/
void **writefile(int dim1, int dim2, double **matname, char *fname){
    // open file for writing
    FILE *fout = fopen(fname, "w");

    // first write dimensions to fit the format
    fprintf(fout, "%d ", dim1);
    fprintf(fout, "%d ", dim2);

    // write matrix to file
    for(int i=0; i<dim1; i++){
        fprintf(fout, "\n%f ", matname[i][0]);
        for(int j=1; j<dim2; j++){
            fprintf(fout, "%f ", matname[i][j]);
        }
    }
    fclose(fout);
}

/*#####################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 1
# Created: April 1, 2019
#
# Perform Matrix Operations
#
# Input: Names of text files containing matrices
# Output: text files containing requested outputs
#
#########################################*/
int main(int argc,char *argv[]){
// Set inputs
char *FileA = argv[1];
char *FileB = argv[2];
char *FileC = argv[3];

// error handling
if (FileA==NULL){
    printf("Error: Please enter 3 file names!\n");
}
if (FileB==NULL){
    printf("Error: Please enter 3 file names!\n");
}
if (FileC==NULL){
    printf("Error: Please enter 3 file names!\n");
}

// initialize dimension variables
int dimA[2], dimB[2], dimC[2], dimAB[2], dimBC[2], dimABC[2];

// file read stuff
FILE *Atag;
Atag = fopen(FileA, "r");

FILE *Btag;
Btag = fopen(FileB, "r");

FILE *Ctag;
Ctag = fopen(FileC, "r");

// scan files' first two characters for dimensions
// A matrix
int tempA;
fscanf(Atag, "%d", &tempA);
dimA[0] = tempA;
fscanf(Atag, "%d", &tempA);
dimA[1] = tempA;

// B matrix
int tempB;
fscanf(Btag, "%d", &tempB);
dimB[0] = tempB;
fscanf(Btag, "%d", &tempB);
dimB[1] = tempB;

// C matrix
int tempC;
fscanf(Ctag, "%d", &tempC);
dimC[0] = tempC;
fscanf(Ctag, "%d", &tempC);
dimC[1] = tempC;

// AB
dimAB[0] = dimA[0];
dimAB[1] = dimB[1];

//BC
dimBC[0] = dimB[0];
dimBC[1] = dimC[1];

//ABC
dimABC[0] = dimAB[0];
dimABC[1] = dimC[1];

fclose(Atag);
fclose(Btag);
fclose(Ctag);

// create matrices
// initialize variables for matrices and matrix operations
double **A, **B, **C, **ABC, **ABpC, **ApBC, **ABmC, **AmBC, **AB, **BC;
AB = createmat(dimAB[0], dimAB[1]);
BC = createmat(dimBC[0], dimBC[1]);
ABC = createmat(dimABC[0], dimABC[1]);
ABpC = createmat(dimAB[0], dimAB[1]);
ABmC = createmat(dimAB[0], dimAB[1]);
ApBC = createmat(dimA[0], dimA[1]);
AmBC = createmat(dimA[0], dimA[1]);

// Read in A, B, and C
A = readfile(FileA);
B = readfile(FileB);
C = readfile(FileC);


// calculate AB, BC for use in requested computations
// AB
if(dimA[1] == dimB[0]){
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, dimA[0], dimB[1], dimA[1], 1.0,
    *A, dimA[1], *B, dimB[1], 0.0, *AB, dimAB[1]);
}
else{
    printf("Error: Dimensions don't match, can't compute AB\n");
}

//BC
if(dimA[1] == dimB[0]){
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, dimB[0], dimC[1], dimB[1],
    1.0, *B, dimB[1], *C, dimC[1], 0.0, *BC, dimBC[1]);
}
else{
    printf("Error: Dimensions don't match, can't compute BC\n");
}
// Compute ABC
if(dimAB[1] == dimC[0]){
    // initialize filename
    char foutABC[35]; //make it large enough for different file names
    sprintf(foutABC, "%s_mult_%s_mult_%s", FileA, FileB, FileC);

    //run matrix operation
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, dimAB[0], dimC[1],
    dimAB[1], 1.0, *AB, dimAB[1], *C, dimC[1], 0.0, *ABC, dimABC[1]);

    // write to file
    writefile(dimABC[0], dimABC[1], ABC, foutABC);
}
else{
    printf("Error: dimensions do not match, cannot perform ABC \n");
}

// Compute AB +/- C
if(dimAB[0] == dimC[0] && dimAB[1] == dimC[1]){
    // initialize filename
    char foutABpC[35];
    sprintf(foutABpC, "%s_mult_%s_plus_%s", FileA, FileB, FileC);
    char foutABmC[35];
    sprintf(foutABmC, "%s_mult_%s_minus_%s", FileA, FileB, FileC);

    // run matrix operations
    // AB+C
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,dimA[0], dimB[1], dimA[1], 1.0, *A,
    dimA[1], *B, dimB[1], 1.0, *ABpC, dimC[1]);
    //AB-C
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,dimA[0], dimB[1], dimA[1], 1.0, *A,
    dimA[1], *B, dimB[1], -1.0, *ABmC, dimC[1]);

    // write file
    writefile(dimAB[0], dimAB[1], ABpC, foutABpC);
    writefile(dimAB[0], dimAB[1], ABmC, foutABmC);

}
else{
    printf("Error: dimensions do not match, cannot perform AB +/- C \n");
}

// compute A +/- BC
if(dimA[0] == dimBC[0] && dimA[1] == dimBC[1]){
    //initialize filenames
    char foutApBC[35];
    sprintf(foutApBC, "%s_plus_%s_mult_%s", FileA, FileB, FileC);
    char foutAmBC[35];
    sprintf(foutAmBC, "%s_minus_%s_mult_%s", FileA, FileB, FileC);

    // run matrix operations
    // A+BC
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, dimB[0], dimC[1], dimB[1], 1.0,
    *B, dimB[1], *C, dimC[1], 1.0, *ApBC, dimA[1]);
    // A-BC
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, dimB[0], dimC[1], dimB[1], -1.0,
    *B, dimB[1], *C, dimC[1], 1.0, *AmBC, dimA[1]);

    // write file
    writefile(dimA[0], dimA[1], ApBC, foutApBC);
    writefile(dimA[0], dimB[1], AmBC, foutAmBC);
}
else{
    printf("Error: dimensions do not match, cannot perform A +/- BC \n");
}
// free pointers
free(A);
free(B);
free(C);
free(AB);
free(BC);
free(ABC);
free(ABpC);
free(ABmC);
free(ApBC);
free(AmBC);
}
