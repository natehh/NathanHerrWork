% Assignment 2 Part 1 - events
% Author: Bailey Topp and Nathan Herr
% Date Created: 1/28/2019
% Professor Tomoko Matsuo
% ASEN 4057
%
% Purpose: To set up the events for ode45
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\

function [value, isterminal, direction] = A2_events(t,y)

% Calculate value
dMS = sqrt((y(1)-y(3))^2+(y(2)-y(4))^2); rM = 1737100;
dES = sqrt((y(1))^2+(y(2))^2); rE = 6371000;
dEM = sqrt((y(3))^2+(y(4))^2); 

% Value
value = [ (dMS - rM), (dES - rE), (2*dEM - dES) ];

% Stop the integration
isterminal = [1, 1, 1];

% Direction settings
direction = [-1, -1, -1];

end