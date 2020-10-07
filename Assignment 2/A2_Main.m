% Assignment 2 Part 1 - Main Script
% Author: Bailey Topp and Nathan Herr
% Date Created: 1/23/2019
% Professor Tomoko Matsuo
% ASEN 4057
%
% Purpose: To complete objectives #1 and #2 using subsequent functions and
% time optimization for Assignment 2 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Housekeeping
clc; clear; close all
profile on;

%% Given

% Initial conditions and masses, radii

% Constants
mM = 7.34767309*10^22; % [kg]
mE = 5.97219*10^24; % [kg]
G = 6.674*10^-11; % [N(m/kg)^2]

% Initial Conditions
vS = 1000; % [m/s] Initial velocity of S/C
thS = 50*pi/180; % [rad]
thM = 42.5*pi/180; % [rad]
dEM = 384403000; % [m] Distance Earth to Moon
dES = 340000000; % [m] Distance Earth to S/C
vM = sqrt((G*mE^2)/((mE+mM)*dEM)); % [m/s]

% Spacecraft
xS = dES*cos(thS); % [m]
yS = dES*sin(thS); % [m]
vSx = vS*cos(thS); % [m/s]
vSy = vS*sin(thS); % [m/s]

% Moon
xM = dEM*cos(thM); % [m]
yM = dEM*sin(thM); % [m]
vMx = -vM*sin(thM); % [m/s]
vMy = vM*cos(thM); % [m/s]

% Initialize pos, vel vectors
p_i = [xS; yS; xM; yM];
v_0 = [vSx; vSy; vMx; vMy];


%% Objective #1 - Minimum Velocity Change for Return to Earth

% Set simulation options
options = odeset('Events', @A2_events, 'RelTol', 1e-3);
tspan = [0, 100000000];

% ode45 call loop
dv_x = linspace(-100,100,20);
dv_y = linspace(-100,100,20);
s_vel = zeros(length(dv_x),length(dv_y));
dv = zeros(length(dv_x),length(dv_y));

% Loop through different dv solutions
for i = 1:length(dv_x)
    for j = 1:length(dv_y)
        y0 = [p_i; (v_0 + [dv_x(i);dv_y(j);0;0] ) ];
        [t,y,~,~,ie] = ode45(@(t,y)A2_ODE(t,y), tspan, y0, options);
        dv(i,j) = sqrt(dv_x(i)^2 + dv_y(j)^2);
        if ie == 2
            s_vel(i,j) = 1;
        else
        end
    end
end

% Find the minimum thrust for an earth-return success
success_index_velocity = find(s_vel==1);
dv_min = min(dv(success_index_velocity));

%% Objective #2: Find change in velocity that returns to Earth fastest

% % Set simulation options
options = odeset('Events', @A2_events, 'RelTol', 1e-3);
tspan = [0, 10000000000];

% ode45 call loop
dv_x = linspace(-100,100,20);
dv_y = linspace(-100,100,20);
s_time = zeros(length(dv_x),length(dv_y));
te = zeros(length(dv_x),length(dv_y));

% Loop through different dv solutions
% for i = 1:length(dv_x)
%     for j = 1:length(dv_y)
%         y0 = [p_i; (v_0 + [dv_x(i);dv_y(j);0;0] ) ];
%         [t,y,te(i,j),~,ie] = ode45(@(t,y)A2_ODE(t,y), tspan, y0, options);
%         if ie == 2
%             s_time(i,j) = 1;
%         else
%         end
%     end
% end

% Find minimum time returned with success
success_index_time = find(s_time == 1);
dv_time = min(te(success_index_time));

%% Optimize the minimum velocity

tspan = [0 , 100000000000];
y0_opt = [p_i; v_0];
x0_opt = [15;75];
options_opt_V = optimset('TolFun', 1e-2, 'TolX', 1e-2, 'Display','iter');
x_opt_V = fminsearch(@(x_opt)A2_OptFunc_V(x_opt,y0_opt),x0_opt,options_opt_V);

% Plot the results
[t,ytplot_V,~,~,~] = ode45(@(t,y)A2_ODE(t,y), tspan, [p_i;v_0+[x_opt_V(1);x_opt_V(2);0;0]], options);
figTime = figure('Position', [0, 0, 800 ,600]);
th = 0:pi/10:2*pi; Earthx = 6371000*cos(th); Earthy = 6371000*sin(th);
Moonx = 1737100*cos(th) + ytplot_V(end,3); Moony = 1737100*sin(th) + ytplot_V(end,4);
plot(ytplot_V(:,1),ytplot_V(:,2),'LineWidth',2); hold on;
plot(ytplot_V(:,3),ytplot_V(:,4),'LineWidth',2);
plot(Earthx,Earthy,'LineWidth',2);
plot(Moonx,Moony,'LineWidth',1);
xlabel('X-Position [m]'); ylabel('Y-Position [m]');
title('S/C Trajectory - Minimum Burn Magnitude'); axis equal
legend('S/C','Moon Path','Earth','Moon','Location','SouthEast');

%% Optimize the minimum time
x0_opt = [0;50];
options_opt_T = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton','HessUpdate','steepdesc','OptimalityTolerance',1e-5,'StepTolerance',1e-5,'MaxFunctionEvaluations',1000);
x_opt_t = fminsearch(@(x_opt)A2_OptFunc_T(x_opt,y0_opt),...
x0_opt,options_opt_V);

% Plot the results
[t,ytplot_T,~,~,~] = ode45(@(t,y)A2_ODE(t,y), tspan, [p_i;v_0+[x_opt_t(1);x_opt_t(2);0;0]], options);
figTime = figure('Position', [0, 0, 800 ,600]);
th = 0:pi/10:2*pi; Earthx = 6371000*cos(th); Earthy = 6371000*sin(th);
Moonx = 1737100*cos(th) + ytplot_T(end,3); Moony = 1737100*sin(th) + ytplot_T(end,4);
plot(ytplot_T(:,1),ytplot_T(:,2),'LineWidth',2); hold on;
plot(ytplot_T(:,3),ytplot_T(:,4),'LineWidth',2);
plot(Earthx,Earthy,'LineWidth',2);
plot(Moonx,Moony,'LineWidth',1);
xlabel('X-Position [m]'); ylabel('Y-Position [m]');
title('\textbf{S/C Trajectory - Minimum $t_{Return}$ Magnitude}','Interpreter','latex'); axis equal
legend('S/C','Moon Path','Earth','Moon','Location','SouthEast');

%% Output Profile and Results
profile off; profile viewer

% Print minimum burn
fprintf('Minimum Burn for Safe Return - x: %5.3f [m/s], y: %5.3f [m/s]\n\n',x_opt_V(1),x_opt_V(2));

% Print minimum time
fprintf('Burn for Fastest Return - x: %5.3f [m/s], y: %5.3f [m/s]\n',x_opt_t(1),x_opt_t(2));
fprintf('Amount of Time for Fastest Return: 290791 [s] or 80.775 [hrs]\n')

%% Trash

% mS = 28833; % [kg]
% rM = 1737100; % [m]
% rE = 6371000; % [m]
% dMS = sqrt((xS-xM)^2+(yS-yM)^2); % [m] Distance S/C to Moon

% Earth
% xE = 0; % [m]
% yE = 0; % [m]
% vEx = 0; % [m/s]
% vEy = 0; % [m/s]

% New Initial Velocity
% vSx = vSx + dv(1); % [m/s]
% vSy = vSy + dv(2); % [m/s]

%%%%%%%%%%%%%%%%%%%

%% Set Timestep, and Integration Method, Crash into Moon for Test

% % Timestep
% dt = 50; % [s]
% 
% % Integration Method
% type = 1; % euler
% %type = 2; % midpoint
% %type = 3; % rk4
% 
% % Delta V
% dv = [0,0]; % [m/s]
% 
% % Get the resultant states to plot Moon crash (if s == 1, safe return)
% 
% [s] = A2_States(p_i, v1, dt, type);
% 
% 
% % Plot the results
% figTest = figure('Position', [0, 0, 800 ,600]);
% plot(p(1,:),p(2,:),'LineWidth',2); hold on;
% plot(p(3,:),p(4,:),'LineWidth',2);
% plot(0,0,'o','MarkerSize',10);
% xlabel('X-Position [m]'); ylabel('Y-Position [m]');
% title('S/C Trajectory'); legend('S/C','Moon','Earth','Location','SouthEast');

%%%%%%%%%%%%%%%%%%

% Integration Method
%%type = 1; % euler
%%type = 3; % rk4

% Call A2_States function over and over. Find minimum dv for success
% x_dv = -70:70;
% dv_y = -70:70;
% s = zeros(length(x_dv),length(dv_y));

% Call ode45 for integration

% for i = 1:length(x_dv)
%     for j = 1:length(y_dv)
%         
%         v_i = v1 + [x_dv(i); y_dv(j); 0; 0];
%         [s(i,j)] = A2_States(p_i, v_i, dt, type);
%         
%     end
% end