#ifndef ASSIGNMENT6_H_INCLUDED
#define ASSIGNMENT6_H_INCLUDED
/*#####################################
# Nathan Herr and Declan Murray
# ASEN 4057 Final Project
# Created: April 23, 2019
#
# This header file defines all functions used
# for the completion of Assignment 6
#
#########################################*/
int Final_events(double dEM, double dSM, double dES, double clearance, double rE, double rM, double time);
void Final_intEuler(double *out, double dVx, double dVy, double clearance, int writecommand, int objective, double tolerance);
void Final_Grid(double *dVarray, int objective, double clearance, double tolerance);
double RK_accel(double F1, double F2, double mass);
double RK_ex(int dt, double IC, double func);
#endif // ASSIGNMENT6_H_INCLUDED
