% Assignment 2 Part 1 - ode45 Function
% Author: Bailey Topp and Nathan Herr
% Date Created: 1/28/2019
% Professor Tomoko Matsuo
% ASEN 4057
%
% Purpose: To set up the equations of motion for ode45 to integrate
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [dydt] = A2_ODE(t,y)

% Call acceleration function
[a,~] = A2_Accel(y(1:4));

% Set velocity
dydt(5:8) = a;

% Set position
dydt(1:4) = y(5:8);

dydt = dydt';

end