%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nathan Herr
% ASEN 4057-Midterm
% Simulate pseudochaotic particle motion (Part 1.1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [t,r] = simulate_particle(tspan, r0, sigma, rho, beta)
%define inputs as global variables
global sigma1 rho1 beta1
sigma1 = sigma; rho1 = rho; beta1 = beta;

% Set options for Part 1.2 to RelTol = 1e-6 and AbsTol = 1e-12
options = odeset('RelTol',1e-6,'AbsTol',1e-12);

% call ode45
[t,results] = ode45(@(t,IC)midtermODE(t,IC),tspan, r0,options);

%define outputs
x = results(:,1);
y = results(:,2);
z = results(:,3);

r = [x,y,z];




end