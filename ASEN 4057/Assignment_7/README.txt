Part 1
1.1:
	compile with: gcc -o mat_ops mat_ops.c -lblas -lgfortran
	run: ./mat_ops A B C

1.2:
	. batch_mat_ops.sh ~/Herr/Assignment_7/Part1

Part 2
	2.1: compile with: gcc -o heat_solve heat_solve.c Build_LHS.c Build_RHS.c Conductivity.c Source.c BC.c Output.c -lm -llapacke -llapack -lblas -lgfortran 
	run: ./heat_solve n_cells problem_index

	2.2: type makefile to clean executable and object files

	2.3: 
From heat_solution_2_1, found in folder "Test Outputs":
0.000000 0.000000 1.000000 
0.000000 0.500000 0.000000 
0.000000 1.000000 0.000000 
0.500000 0.000000 0.000000 
0.500000 0.500000 0.250000 
0.500000 1.000000 0.000000 
1.000000 0.000000 1.000000 
1.000000 0.500000 1.000000 
1.000000 1.000000 1.000000 


from heat_solution_2_2, found in folder "Test Outputs":
0.000000 0.000000 0.000000 
0.000000 0.500000 0.000000 
0.000000 1.000000 0.000000 
0.500000 0.000000 0.000000 
0.500000 0.500000 0.062500 
0.500000 1.000000 0.000000 
1.000000 0.000000 0.000000 
1.000000 0.500000 0.000000 
1.000000 1.000000 0.000000 

