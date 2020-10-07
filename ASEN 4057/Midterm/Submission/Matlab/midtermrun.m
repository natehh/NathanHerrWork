clearvars; clc; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nathan Herr
% ASEN 4057-Midterm
% Script to run and time function (part 1.2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define inputs
sigma = 10; 
rho = 28; 
beta = 8/3; 
r0 = [-8, 8, 27]; 
tspan = [0, 20];

%time runtime
tic
% call simulate_particle 
[t,r] = simulate_particle(tspan, r0, sigma, rho, beta);
toc

% define outputs
x = r(:,1);
y = r(:,2);
z = r(:,3);

% plot results 
figure
hold on
plot3(x,y,z,'Linewidth',2)
title('Particle Trajectory with Doubled Tolerance')
xlabel('x Displacement (m)')
ylabel('y Displacement')
zlabel('z Displacement')
hold off

