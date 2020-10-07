#ifndef ASSIGNMENT6_H_INCLUDED
#define ASSIGNMENT6_H_INCLUDED
/*#####################################
# Nathan Herr
# ASEN 4057 Assignment 6
# Created: March 5, 2019
#
# This header file defines all functions used
# for the completion of Assignment 6
#
#########################################*/
int A6_events(double dEM, double dSM, double dES, double clearance, double rE, double rM, double time);
void A6_intEuler(double *out, double dVx, double dVy, double clearance, int writecommand, int objective, double tolerance);
void A6_Grid(double *dVarray, int objective, double clearance, double tolerance);

#endif // ASSIGNMENT6_H_INCLUDED
