################################################################################
# Nathan Herr
# ASEN 4057 Assignment 7 Part 2.2
# Created: April 16, 2019
#
# makefile 
#
###############################################################################

.PHONY: clean
CC = gcc
CSTUFF = -c
LSTUFF = -lm -llapacke -llapack -lblas -lgfortran
OBJS = heat_solve.o Build_LHS.o Build_RHS.o Conductivity.o Source.o BC.o Output.o

all: $(OBJS)
	$(CC) -o $@ $^ $(LSTUFF)

$(OBJS) : %.o: %.c
	$(CC) $(CSTUFF) $<


heat_solve.o: Build_LHS.h Build_RHS.h Conductivity.h Source.h BC.h Output.h

Build_LHS.o: Build_LHS.h

Build_RHS.o: Build_RHS.h

Conductivity.o: Conductivity.h

Source.o: Source.h

BC.o: BC.h

Output.o: Output.h

clean:
	rm -rf *.o all


