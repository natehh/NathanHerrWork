%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nathan Herr
% ASEN 4057-Midterm
% Function to be passed into ode45
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dydt = midtermODE(t,IC)
%define global variables
global sigma1 rho1 beta1
% define inputs
x = IC(1); y = IC(2); z = IC(3);
% create outputs
dydt(1) = -sigma1*x+sigma1*y;
dydt(2) = rho1*x-y-x*z;
dydt(3) = -beta1*z+x*y;

%transpose output
dydt = dydt';

end

