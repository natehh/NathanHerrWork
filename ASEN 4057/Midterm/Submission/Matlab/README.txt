1.1: The function for part 1.1 is called simulate_particle, as instructed, and calls midtermODE.m to complete the integration
1.2: The function is set to have the doubled relative and absolute tolerances by using the options functionality. In order to revert to the default, simply comment out the options variable and remove the options input from the ode45 call. The script midtermrun.m runs the function with the specified inputs, times the run, and plots the 3D trajectory. The requested report can be found in the Matlab directory within the Submissions directory.
1.3: The gui is represented by the file midtermgui.fig, and the callback functions are found in midtermgui.m. The pushbutton callback function, named "simulate", contains the code which takes the inputs from the edited text boxes, calls the simulate_particle function, and runs the function midtermplotter.m to create the requested 2D and 3D plots on the GUI.

NOTE: all inputs to the text edit boxes on the GUI should be integers or decimals, not fractions. 
EXAMPLE: 8/3 should be entered as 2.6666667
