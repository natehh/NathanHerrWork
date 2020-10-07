################################################################################
# Nathan Herr and Declan Murray
# ASEN 4057 Final Project Part 1
# Created: April 14, 2019
#
# makefile 
#
###############################################################################

.PHONY: clean
CC = mpicc
CSTUFF = -c
LSTUFF = -lm
OBJS = Final_main.o

ThreeBody: $(OBJS)
	$(CC) -o $@ $^ $(LSTUFF)

$(OBJS) : %.o: %.c
	$(CC) $(CSTUFF) $<


Final_main.o: Final_main.h

clean:
	rm -rf *.o all


