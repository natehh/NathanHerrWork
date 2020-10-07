function dydt = targethit_ODEFunc(t,y)
%ID:177
%Purpose: Numerically integrate state variables realated to the flight of a
%bottle rocket
%input: Given test case variables
%output: vectors of 7 state variables with respect to time
%assumptions: my grader recognizes that I submitted two separate ODE's,
%flight only in x and z directions, the given equations can be used to
%correctly model the flight of a bottle rocket, tspan = [0 5], negligible
%wind, drag coefficient and discharge coefficient are precise and correct
%date created:12/5/17
%date modified:12/6/17
%define variables
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
%useful calculations
Abott = dBott^2*.25*pi; %m^2
Athroat = dThroat^2*.25*pi; %m^2
PtotI = Patm + Pg;
Vairi = Vbott - Vwati;
mAirI = (PtotI * Vairi)/(R*Tairi);
mWaterI = rhoWat * Vwati;
mRocketI = mBott + mWaterI + mAirI;
%ODE return values
mAir = y(1);
mRocket = y(2);
Vair = y(3);
Vx = y(4);
Vz = y(5);
z = y(6);
x = y(7);
%define thrust variable for graphing thrust profile
global Thrust1
global Thrust2
global Thrust3

%more useful calculations
V = sqrt(Vx^2+Vz^2);
drag = (rhoAirAmb/2)*V^2*CD*Abott;
%if off stand, find h, else use cos or sin
if sqrt(x^2 + (z-z0)^2) > L
    hx = Vx/V;
    hz = Vz/V;
else
    hx = cos(theta);
    hz = sin(theta);
end
%% Phase one conditions
%using equations from phase one section of project document 
if Vair<Vbott
    pressure = PtotI*(Vairi/Vair)^gamma;
    dydt(1) = 0;
    dydt(2) = -Cd*Athroat*sqrt(2*rhoWat*(pressure-Patm));
    dydt(3) = Cd*Athroat*sqrt((2/rhoWat)*(pressure-Patm));
    Ve = sqrt((2*(pressure-Patm))/rhoWat);
    thrust = 2*Cd*(pressure-Patm)*Athroat;
    dydt(4) = (hx*(thrust-drag))/mRocket;
    dydt(5) = (hz*(thrust-drag))/mRocket-g;
    dydt(6) = Vz;
    dydt(7) = Vx;
    Thrust1 = [Thrust1; thrust t];
    %% Phase two conditions
else
    %define new P and T
    Pfinal = PtotI*(Vairi/Vbott)^gamma;
    Pnew = Pfinal*(mAir/mAirI)^gamma;
    Tfinal = Tairi*(Vairi/Vbott)^(gamma-1);
    if Pnew > Patm
        %if internal pressure>atmospheric, define new quantities using
        %given equations
        rho = mAir/Vbott;
        T = Pnew/(R*rho);
        Pcritical = Pnew*(2/(gamma+1))^(gamma/(gamma-1));
        if Pcritical > Patm
            %If Pcritical>Patm, define new quantities using given equations
            P_e = Pcritical;
            T_e = (2/(gamma+1))*T;
            rho_e = P_e/(R*T_e);
            V_e = sqrt(gamma*R*T_e);
        else
            %if not, define using different equations
            P_e = Patm;
            M_e = sqrt((2/(gamma-1))*((Pnew/Patm)^((gamma-1)/gamma)-1));
            T_e = T*(1+(((gamma-1)/2)*M_e^2));
            rho_e = P_e/(R*T_e);
            V_e = M_e*sqrt(gamma*R*T_e);
        end
        %set phase 2 dydt values and thrust
        thrust = Cd*rho_e*Athroat*V_e^2+((P_e-Patm)*Athroat);
        dydt(1) = -Cd*rho_e*Athroat*V_e;
        dydt(2) = -Cd*rho_e*Athroat*V_e;
        dydt(3) = 0;
        dydt(4) = (hx*(thrust-drag))/mRocket;
        dydt(5) = (hz*(thrust-drag))/mRocket-g;
        dydt(6) = Vz;
        dydt(7) = Vx;
        Thrust2 = [Thrust2; thrust t];
    else
        %% Phase 3
        %define phase 3 dydt values
        dydt(1) = 0;
        dydt(2) = 0;
        dydt(3) = 0;
        dydt(4) = (hx*(-drag))/mRocket;
        dydt(5) = (hz*(-drag))/mRocket-g;
        dydt(6) = Vz;
        dydt(7) = Vx;
        thrust = 0;
        Thrust3 = [Thrust3; thrust t];
    end

end
%transpose dydt
dydt = dydt';
end
