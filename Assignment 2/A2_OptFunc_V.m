% Assignment 2 Part 1 - Velocity Optimization
% Author: Bailey Topp and Nathan Herr
% Date Created: 1/30/2019
% Professor Tomoko Matsuo
% ASEN 4057
%
% Purpose: To find the minimum time to return to earth
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function out = A2_OptFunc_V(x_opt,y0)

% Set simulation options
options = odeset('Events',@A2_events,'RelTol',1e-5);
tspan = [0 100000000000000];

% Set dv_x and dv_y
y0(5) = y0(5) + x_opt(1);
y0(6) = y0(6) + x_opt(2);

% ode45 call
[t,y,te,ye,ie] = ode45(@(t,y)A2_ODE(t,y),tspan,y0,options);

% Tricks
mag = sqrt(x_opt(1)^2 + x_opt(2)^2);

if ie ~= 2
    mag = mag + 10000000000;
end

out = mag;
end