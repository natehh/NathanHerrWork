% Assignment 2 Part 1 - Acceleration Function
% Author: Bailey Topp and Nathan Herr
% Date Created: 1/24/2019
% Professor Tomoko Matsuo
% ASEN 4057
%
% Purpose: To calculate the accelerations of the S/C and the Moon at a
% given (x,y) location for each
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [a,d] = A2_Accel(p)

%% Given

% Note: p(1) = xS, p(2) = yS, p(3) = xM, p(4) = yM, xE,yE = 0

% Mass properties
mM = 7.34767309*10^22; % [kg]
mE = 5.97219*10^24; % [kg]
mS = 28833; % [kg]
G = 6.674*10^-11; % [N(m/kg)^2]

%% Solution

% Caclulate distance
d(1) = sqrt((p(1)-p(3))^2+(p(2)-p(4))^2); % [m] Distance S/C to Moon
d(2) = sqrt((p(1)-0)^2+(p(2)-0)^2); % [m] Distance S/C to Earth
d(3) = sqrt((p(3)-0)^2+(p(4)-0)^2); % [m] Distance Moon to Earth
% d(1) = dMS; d(2) = dES; d(3) = dEM;

% Calculate forces: x-components
FMSx = G*mS*mM*(p(3)-p(1))/d(1)^3; FSMx = -FMSx; % [N]
FESx = G*mE*mS*(0-p(1))/d(2)^3; % [N]
FEMx = G*mE*mM*(0-p(3))/d(3)^3; % [N]

% Calculate forces: y-components
FMSy = G*mS*mM*(p(4)-p(2))/d(1)^3; FSMy = -FMSy; % [N]
FESy = G*mE*mS*(0-p(2))/d(2)^3; % [N]
FEMy = G*mE*mM*(0-p(4))/d(3)^3; % [N]

% Add forces for acceleration
a(1) = (FMSx + FESx)/mS;
a(2) = (FMSy + FESy)/mS;
a(3) = (FEMx + FSMx)/mM;
a(4) = (FEMy + FSMy)/mM;

end