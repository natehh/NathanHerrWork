#ifndef MAT_OPS_H_INCLUDED
#define MAT_OPS_H_INCLUDED
double **createmat(int row, int col);
double **readfile(char *fname);
void **writefile(int dim1, int dim2, double **matname, char *fname);

#endif // MAT_OPS_H_INCLUDED
