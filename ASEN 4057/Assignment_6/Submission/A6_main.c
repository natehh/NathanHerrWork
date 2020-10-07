#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include"A6_main.h"


/*#####################################
# Nathan Herr
# ASEN 4057 Assignment 6
# Created: March 5, 2019
#
# Events function to determine if simulation
# has reached end condition
#
# Input: Distances between bodies, user
#        defined clearance, time, radii
# Output: Integer end condition
#
#########################################*/
int A6_events(double dEM, double dSM, double dES, double clearance, double rE, double rM, double time){
    // create variable for end condition
    int endcon;

    // Spacecraft hits moon
    if (dSM <= rM+clearance){
        endcon = 1;
        return(endcon);
    }

    // Spacecraft hits earth
    else if (dES <= rE){
        endcon = 2;
        return(endcon);
    }

    // Spacecraft is lost to space
    else if (dES >= 2*dEM){
        endcon = 3;
        return(endcon);
    }

    // Set an upper time limit of 3 weeks
    else if (time >= 21*24*3600){
        endcon = 4;
        return(endcon);
    }

    // Simulation has not yet reached end condition
    else{
        endcon = 0;
        return(endcon);
    }
}

/*#######################################################
# Nathan Herr
# ASEN 4057 Assignment 6
# Created: March 5, 2019
#
# Function to perform Numerical integration
# using Euler's method
#
# Input: pointer to outputs for output array, velocity
#        change in x and y directions, clearance, tolerance,
#        and printing writecommand
# Output:
#
#########################################################*/
void A6_intEuler(double *out, double dVx, double dVy, double clearance, int writecommand, int objective, double tolerance){
    // Define variables
    //constants
	double mM,mE,mS,rM,rE,mclear,G;
	mM = 7.34767309e22;//kg
	mE = 5.97219e24;// kg
	mS = 28833;// kg
	rM = 1737100; // m
	rE = 6371000; // m
	mclear = rM + clearance; // m
	G = 6.674e-11; // N(m/kg)^2

	// Initial Conditions
	double vS,dEM[2],dES[2],vM,thS,thM;
	vS = 1000; // [m/s] Initial S/C Velocity
	thS = 50*(M_PI/180); // rad
	thM = 42.5*(M_PI/180); // rad
	dES[0] = 340000000; // [m] distance Earth to S/C
	dEM[0] = 384403000; // [m] distant Earth to Moon
	vM = sqrt((G*pow(mE,2))/((mE+mM)*dEM[0])); // m/s

	// Spacecraft
	double xS[2],yS[2],vSx[2],vSy[2],vSx0,vSy0;
	xS[0] = dES[0]*cos(thS); // m
	yS[0] = dES[0]*sin(thS); // m
	vSx0 = vS*cos(thS); // m/s
	vSy0 = vS*sin(thS); // m/s
	vSx[0] = vSx0+dVx; // m/s
	vSy[0] = vSy0+dVy; // m/s

	// Moon
	double xM[2],yM[2],vMx[2],vMy[2],dSM[2];
	xM[0] = dEM[0]*cos(thM); // m
	yM[0] = dEM[0]*sin(thM); // m
	vMx[0] = -vM*sin(thM); // m/s
	vMy[0] = vM*cos(thM); // m/s
	dSM[0] = sqrt(pow((xS[0]-xM[0]),2)+pow((yS[0]-yM[0]),2)); // m

	// Earth
	double xE,yE,vEx,vEy;
	xE = 0; yE = 0;
	vEx = 0; vEy = 0;

	// Forces: x components
	double FMSx[2],FMEx[2],FSEx[2],FSMx[2],FEMx[2],FESx[2];
	FMSx[0] = (G*mS*mM*(xM[0]-xS[0]))/pow(dSM[0],3);
	FMEx[0] = (G*mE*mM*(xM[0]-xE))/pow(dEM[0],3);
	FSEx[0] = (G*mE*mS*(xS[0]-xE))/pow(dES[0],3);
	FSMx[0] = -FMSx[0]; FEMx[0] = -FMEx[0]; FESx[0] = -FSEx[0];

	// Forces: y components
    double FMSy[2],FMEy[2],FSEy[2],FSMy[2],FEMy[2],FESy[2];
	FMSy[0] = (G*mS*mM*(yM[0]-yS[0]))/pow(dSM[0],3);
	FMEy[0] = (G*mE*mM*(yM[0]-yE))/pow(dEM[0],3);
	FSEy[0] = (G*mE*mS*(yS[0]-yE))/pow(dES[0],3);
	FSMy[0] = -FMSy[0]; FEMy[0] = -FMEy[0]; FESy[0] = -FSEy[0];

	// Open text file
	//define file name pointer to a sufficient size
	char *fname = malloc(sizeof(char)*50);
	if (writecommand==1){
        char outobjective[4], outclearance[10], outtolerance[4];
        snprintf(outobjective, 4, "%d", objective);
        snprintf(outclearance, 10, "%.0f", clearance);
        snprintf(outtolerance, 4, "%.1f", tolerance);
        snprintf(fname, 50*sizeof(char), "Output/Optimum_%s_%s_%s", outobjective, outclearance,outtolerance);
        for (int i=0; fname[i] != '\0';i++){
            if (fname[i] == '.'){
                fname[i] = 'p';
                }
        }
	}

	FILE *fp = fopen(fname,"w");

	// conditions for while loop
    double dt,endcon,t; int i;
    t = 0;
    dt = 30; // s
    endcon = 0;
    i = 1;

    // loop to perform Numerical Integration (Euler's)
    while (endcon == 0){
        // Spacecraft velocity
        vSx[1] = vSx[0] + ((FMSx[0]+FESx[0])/mS)*dt;
        vSy[1] = vSy[0] + ((FMSy[0]+FESy[0])/mS)*dt;

        // Moon velocity
        vMx[1] = vMx[0] + ((FEMx[0]+FEMx[0])/mM)*dt;
        vMy[1] = vMy[0] + ((FEMy[0]+FEMy[0])/mM)*dt;

        // Spacecraft Position
        xS[1] = xS[0] + vSx[0]*dt;
        yS[1] = yS[0] + vSy[0]*dt;

        // Moon position
        xM[1] = xM[0] + vMx[0]*dt;
        yM[1] = yM[0] + vMy[0]*dt;

        // Distances between bodies
        dES[1] = sqrt(pow((xS[1]-xE),2)+pow((yS[1]-yE),2));
        dEM[1] = sqrt(pow((xE-xM[1]),2)+pow((yE-yM[1]),2));
        dSM[1] = sqrt(pow((xS[1]-xM[1]),2)+pow((yS[1]-yM[1]),2));

        // Forces: x direction
        FMSx[1] = (G*mS*mM*(xM[1]-xS[1]))/pow(dSM[1],3);
        FMEx[1] = (G*mE*mM*(xM[1]-xE))/pow(dEM[1],3);
        FSEx[1] = (G*mE*mS*(xS[1]-xE))/pow(dES[1],3);
        FSMx[1] = -FMSx[1]; FEMx[1] = -FMEx[1]; FESx[1] = -FSEx[1];

        // Forces: y direction
        FMSy[1] = (G*mS*mM*(yM[1]-yS[1]))/pow(dSM[1],3);
        FMEy[1] = (G*mE*mM*(yM[1]-yE))/pow(dEM[1],3);
        FSEy[1] = (G*mE*mS*(yS[1]-yE))/pow(dES[1],3);
        FSMy[1] = -FMSy[1]; FEMy[1] = -FMEy[1]; FESy[1] = -FSEy[1];


        // Check Events function to see if stopping condition has been satisfied
        endcon = A6_events(dEM[1], dSM[1], dES[1], clearance, rE, rM, t);

        // Update t and j
        t = t+dt;
        i++;

        // Rearrange arrays to prepare for next run
        vSx[0] = vSx[1]; vSy[0] = vSy[1];
        vMx[0] = vMx[1]; vMy[0] = vMy[1];
        xS[0] = xS[1]; yS[0] = yS[1];
        xM[0] = xM[1]; yM[0] = yM[1];
        dES[0] = dES[1]; dEM[0] = dEM[1]; dSM[0] = dSM[1];
        FMSx[0] = FMSx[1]; FMEx[0] = FMEx[1]; FSEx[0] = FSEx[1];
        FSMx[0] = FSMx[1]; FEMx[0] = FEMx[1]; FESx[0] = FESx[1];
        FMSy[0] = FMSy[1]; FMEy[0] = FMEy[1]; FSEy[0] = FSEy[1];
        FSMy[0] = FSMy[1]; FEMy[0] = FEMy[1]; FESy[0] = FESy[1];

        // Print to file (output)
        if (writecommand == 1){
            fprintf(fp,"%f %f %f %f %f %f\n",xS[1],yS[1],xM[1],yM[1],xE,yE);

    }

}
// Final outputs
if (writecommand==1){
    fclose(fp);
        if(endcon == 1){
            printf("\nIntegration Result:\tThe Spacecraft has hit the Moon\n");
        }
        else if(endcon == 2){
            printf("\nIntegration Result:\tThe Spacecraft has returned to Earth\n");
        }
        else if(endcon == 3){
            printf("\nIntegration Result:\tThe Spacecraft has flown into space\n");
        }
        else if(endcon == 4){
            printf("\nIntegration Result:\tFlight has timed out\n");
        }

    }

    // Return output arrays
    out[0] = endcon;
    out[1] = t;
    free(fname);
}
/*#######################################################
# Nathan Herr
# ASEN 4057 Assignment 6
# Created: March 11, 2019
#
# Function to perform Grid search for result optimization
#
# Input: pointer for output array, objective, clearance,
#        tolerance
# Output: deltaV pointer
#
#########################################################*/
void A6_Grid(double *dVarray, int objective, double clearance, double tolerance){

    // initialize output array
    double dVmin[2], tmin[2], endcon, dV[2], magdV, t;
    double *out = malloc(2*sizeof(double));

    // dV initial condition
    dV[0] = 1000; // m/s
    int writecommand = 0;
    double gsize=5;
    double min=-100;
    double max=100;

    // Objective check
    printf("\nSimulating Objective %d...\n",objective);

    // If objective 1 is chosen
    if (objective==1){
        // Coarse Grid Search
        printf("\n\n\nCoarse Grid Search...\n\n\n");
        for (int i=min; i<=max; i+=gsize){
            for (int j=min; j<=max; j+=gsize){
                // Call Euler's
                A6_intEuler(out, i, j, clearance, writecommand, objective, tolerance);
                endcon = (int)*out;

                // For successful iteration
                if (endcon==2){
                    dV[1] = sqrt(pow(i,2)+pow(j,2));
                    if (dV[1]<=dV[0]){
                        dVmin[0] = i;
                        dVmin[1] = j;
                        dV[0] = dV[1];
                    }

                }
            }
        }


        printf("\nGuess from agnostic search:\tdVx = %0.3f m/s\n\t\t\t\tdVy = %0.3f m/s\n",dVmin[0],dVmin[1]);
        printf("\n\n\nFine Grid Search...\n\n\n");

        // reset delta V
        dV[0] = 1000;

        // fine grid search
        for (float i=dVmin[0]-gsize/5; i<=dVmin[0]+gsize/5; i+=tolerance){
            for (float j=dVmin[1]-(gsize-2); j<=dVmin[1]+(gsize-2); j+=tolerance){
                // Perform integration
                A6_intEuler(out, i, j, clearance, writecommand, objective, tolerance);
                // Set end condition
                endcon = (int)*out;
                // For successful iteration
                if (endcon==2){
                    dVmin[0] = i;
                    dVmin[1] = j;
                    dV[0] = dV[1];
                }
            }
        }
    }



    // If objective 2 is chosen
    if (objective==2){
        // set tmin
        tmin[0] = 21*24*3600;
        // Coarse Grid Search
        printf("\n\n\nCoarse Grid Search...\n\n\n");
        for (int i=min; i<=max; i+=gsize){
            for (int j=min; j<=max; j+=gsize){
                // check total velocity
                magdV = sqrt(pow(i,2)+pow(j,2));
                // Perform integration
                A6_intEuler(out,i,j,clearance, writecommand, objective, tolerance);
                endcon = (int)*out;
                t = *(out+1);
                // For successful iteration
                if (endcon==2 && magdV<=100){
                    tmin[1] = t;
                    if (tmin[1]<=tmin[0]){
                        dVmin[0] = i;
                        dVmin[1] = j;
                        tmin[0] = tmin[1];
                    }

                }

            }
        }

        // report coarse grid result
        printf("\nGuess from agnostic search:\tdVx = %0.3f m/s\n\t\t\t\tdVy = %0.3f m/s\n",dVmin[0],dVmin[1]);
        printf("\n\n\nFine Grid Search...\n\n\n");

        // reset tmin variable
        tmin[0] = 21*24*3600;

        // fine grid search
        for (float i=dVmin[0]-gsize/5; i<=dVmin[0]+gsize/5; i+=tolerance){
            for (float j=dVmin[1]-(gsize-2); j<=dVmin[1]+(gsize-2); j+=tolerance){
                //define total velocity
                magdV = sqrt(pow(i,2)+pow(j,2));

                // run integration
                A6_intEuler(out, i, j, clearance, writecommand, objective, tolerance);

                // encond and time definition
                endcon = (int)*out;
                t = *(out+1);
                // For successful iteration
                if (endcon==2 && magdV<=100){
                    tmin[1] = t;
                    if (tmin[1]<=tmin[0]){
                        dVmin[0] = i;
                        dVmin[1] = j;
                        tmin[0] = tmin[1];
                    }

                }
            }
        }
    }
    // Set dVarray outputs
    dVarray[0] = dVmin[0]; dVarray[1] = dVmin[1];

    // Print results
    printf("\n\nFinal delta V values for objective %d:\tdVX = %0.3f m/s\n\t\t\t\t\tdVy = %0.3f m/s\n\n",objective,*dVarray,*(dVarray+1));


    if (objective==1){
        printf("The minimum change in velocity to return to Earth is %0.3f m/s\n",sqrt(pow(dVmin[0],2)+pow(dVmin[1],2)));
    }

    if (objective==2){
        printf("The minimum time to return to Earth is %0.3f days\nThe change in velocity is %0.3f\n\n",t/(24*3600),sqrt(pow(dVmin[0],2)+pow(dVmin[1],2)));

    }

    // Free up variables
    free(out);
}

/*#######################################################
# Nathan Herr
# ASEN 4057 Assignment 6
# Created: March 12, 2019
#
# Run all previously defined functions
#
# Input: Objective 1 or 2, clearance from moon, tolerance
# Output: data file
#
#########################################################*/
int main(int argc, char *argv[]){
    // set output array pointers
    double dVx, dVy;
    double *dVarray = malloc(2*sizeof(double));
    double *place = malloc(2*sizeof(double));
    dVx = 0; dVy = 0;

    // set command line inputs, handle error

    //objective
    int objective = atoi(argv[1]);
    if (objective != 1 && objective !=2){
        printf("\nError: %d is not a valid input. Please enter 1 or 2\n\n",objective);
        return(-1);
    }

    // clearance
    double clearance = atof(argv[2]);
    if (clearance<0){
        printf("\nError: %0.3f is not a valid input. Please enter a positive clearance\n\n",clearance);
        return(-1);
    }

    // tolerance
    double tolerance = atof(argv[3]);
    if (tolerance<=0){
        printf("\nError: %0.3f is not a valid input. Please enter a positive tolerance\n\n",tolerance);
        return(-1);
    }

    // Call grid search function
    A6_Grid(dVarray, objective, clearance, tolerance);
    // create inputs for integration call
    dVx = *dVarray; dVy = *(dVarray+1);

    // integration call
    int writecommand = 1;
    A6_intEuler(place, dVx, dVy, clearance, writecommand, objective, tolerance);

    // free up pointers
    free(place);
    free(dVarray);

    // return on success
    return 1;

}
