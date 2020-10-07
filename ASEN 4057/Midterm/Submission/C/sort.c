#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#include"sort.h"
/*#######################################################
# Nathan Herr
# ASEN 4057 Assignment 6
# Created: March 19, 2019
#
# Perform bubble sort on an array
#
# Input: input array, length of array
#
#########################################################*/
void sort(int input[], int length){
// nested for loop to perform bubble sort
for (int i=0; i<length-1; i++){
    for (int j=0; j<length-i-1; j++){
    // compare adjacent values, swap them if needed
        if (input[j]>=input[j+1]){
        // define placeholder variable to facilitate swap
            int pholder = input[j];
            input[j] = input[j+1];
            input[j+1] = pholder;
        }
    }
}
}
/*#######################################################
# Nathan Herr
# ASEN 4057 Assignment 6
# Created: March 19, 2019
#
# Part 2 of midterm assignment
#
# Input: option 1 or 2, number of inputs or file
#
#########################################################*/
int main (int argc, char *argv[]){
    // set command line arguments
    int option = atoi(argv[1]);
    // error message if option is not 1 or 2
    if (option != 1 && option !=2){
        printf("\nError: %d is not a valid input. Please enter 1 or 2\n\n",option);
        return(-1);
    }

    // option 1 stuff
    if (option ==1){
        // initialize variables for sort function from command line input
        int length = atoi(argv[2]);
        int *input = malloc(length*sizeof(int));
        // prompt for list input
        printf("\nWelcome to my sort function!\n Please enter %d integers, separated by spaces:\n",length);
        for (int n=0; n<length; n++){
            scanf("%d",&input[n]);
        }
        // call sort function
        sort(input, length);
        // print results of sort
        printf("\n\n\nHere is your sorted list!:\n");
        for (int k=0; k<length; k++){
            printf("%d\n",input[k]);
        }
    }

    // Option 2 stuff
    if (option == 2){
        // save argv[2] for file naming later
        char *finname = argv[2];
        // open input file
        FILE *fname = fopen(argv[2], "r");
        // error if file does not exist
        if (fname == NULL){
            printf("Error: File does not exist\n");
            return(-1);
        }
        // test number of integers using getc, counter variable (ignoring spaces)
        char read;
        int k=0;
        while((read=getc(fname)) != EOF){
            if (read != ' '){
                k++;
            }
        }
        fclose(fname);

        // open file to read it
        FILE *fname2 = fopen(argv[2], "r");
        int length = k-1;
        // allocate the input array to be the size of the file
        int input[length];
        // read integers from file into array
        for (int n=0; n<length; n++){
            fscanf(fname2, "%d", &input[n]);
        }
        // call sort function
        sort(input, length);


        // file output
        // create output name
        // find length of finname
        int titlelength = strlen(finname);
        // allocate space for the extra character
        char *foutname = malloc(titlelength+1);
        // copy finname, change "in" to "out"
        strcpy(foutname,finname);
        foutname[titlelength-2] = 'o';
        foutname[titlelength-1] = 'u';
        foutname[titlelength] = 't';

        // file printing
        FILE *foutput = fopen(foutname,"w");
        for (int c=0; c<length; c++){
            fprintf(foutput,"%d\n",input[c]);
        }

        // print message
        printf("See %s for your sorted list!\n",foutname);

        // free fname
        free(fname);
        free(fname2);
    }

// return on success
return 0;
}



