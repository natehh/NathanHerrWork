%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nathan Herr
% ASEN 4057-Midterm
% Plot requested figures (Part 1.3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  midtermplotter(t, r, handle)
%define input
x = r(:,1);
y = r(:,2);
z = r(:,3);

% plots
h1 = subplot(2,2,1, 'Parent', handle); plot(t,x)
hold(h1, 'on')
xlabel(h1, 'time (seconds)')
ylabel(h1, 'x location (meters)')
title(h1, 'x location vs. time')
hold(h1, 'off')

h2 = subplot(2, 2, 2, 'Parent', handle); plot(t,y)
hold(h2, 'on')
xlabel(h2, 'time (seconds)')
ylabel(h2, 'y location (meters)')
title(h2, 'y location vs. time')
hold(h2, 'off')

h3 = subplot(2, 2, 3, 'Parent', handle); plot(t,z)
hold(h3, 'on')
xlabel(h3, 'time (seconds)')
ylabel(h3, 'y location (meters)')
title(h3, 'y location vs. time')
hold(h3, 'off')

h4 = subplot(2, 2, 4, 'Parent', handle); plot3(x,y,z)
hold(h4, 'on')
xlabel('x location (meters)')
ylabel('y location (meters)')
zlabel('z location (meters)')
title('3D plot of particle locations')
hold(h4, 'off')



end

