clear all; clc; close all;
%% Header
%ID:177
%Purpose: Predict the trajectory and thrust profile of a bottle rocket, and
%determine the values of certain variables throughout its flight
%input: Given test case variables, ODE function
%output: Plots of flight trajectory and thrust profile, vectors of 7 state variables
%with respect to time
%assumptions: my grader recognizes that I submitted two separate ODE's,
%flight only in x and z directions, the given equations can be used to
%correctly model the flight of a bottle rocket, tspan = [0 5], negligible
%wind, drag coefficient and discharge coefficient are precise and correct
%date created:12/5/17
%date modified:12/6/17
%% Hitting 75m target
%%define variables
g = 9.81; %m/s^2
Cd = .8; %discharge coeff
rhoAirAmb = .961; %kg/m^3
Vbott = .002; %m^3
Patm = 83426.56; %pa
gamma = 1.4; %specific heat ratio
rhoWat = 1000; %kg/m^3
dThroat = .021; %m
dBott = .105; %m
R = 287; %J/kgK
mBott = .15; %kg
CD = .5; %drag coefficient
Pg = 457000; %Pa
Vwati = .001; %m^3
Tairi = 300; %K
V0 = 0; %m/s
theta = pi/4; %radians
x0 = 0; %m
z0 = .01; %m
L = .5; %m
tspan = [0 5]; %s
%define thrust for thrust profile
global Thrust1
Thrust1 = [];
global Thrust2
Thrust2 = [];
global Thrust3
Thrust3 = [];
%calculate useful quantities
Abott = dBott^2*.25*pi; %m^2
Athroat = dThroat^2*.25*pi; %m^2
PtotI = Patm + Pg;
Vairi = Vbott - Vwati;
mAirI = (PtotI * Vairi)/(R*Tairi);
mWaterI = rhoWat * Vwati;
mRocketI = mBott + mWaterI + mAirI;
%call ode
Options = odeset('Maxstep',10^(-3));
[t,y] = ode45('targethit_ODEFunc',tspan,[mAirI,mRocketI,Vairi,0,0,z0,0],Options);
%define ode returns
mAir = y(:,1);
mRocket = y(:,2);
Vair = y(:,3);
Vx = y(:,4);
Vz = y(:,5);
z = y(:,6);
x = y(:,7);

%% Target hit: Trajectory plot
%find max height and distance and plot trajectory
zMax = max(z)
landIndex = find(z<0);
xMax = x(landIndex(1))
figure(1)
hold on
plot(x,z)
xlim([0,xMax])
ylim([0,zMax])
xlabel('Distance (m)')
ylabel('Height (m)')
title('Height vs Distance')
hold off


%% Target hit: Thrust plot
%find max thrust and graph thrust profile
figure(2)
thrustMax = max(Thrust1(:,1))
hold on
plot(Thrust1(:,2),Thrust1(:,1),'linewidth',2)
plot(Thrust2(:,2),Thrust2(:,1),'linewidth',2)
plot(Thrust3(:,2),Thrust3(:,1),'linewidth',2)
plot([Thrust1(end,2) Thrust1(end,2)],[0 200],'r-.')
plot([Thrust2(end,2) Thrust2(end,2)],[0 200],'r-.')
xlim([0, Thrust3(1,2)+.1])
ylim([0,thrustMax])
title('Thrust Profile (Thrust vs. time)')
xlabel('Time (seconds)')
ylabel('Thrust (N)')
legend('Phase one', 'Phase two','Phase three')
hold off










