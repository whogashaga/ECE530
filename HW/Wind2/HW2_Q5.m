%% Parameters
z0 = 0.18; % Terrain characterization, CHANGE VALUE TO 0.18
us = 10.07; % Observed wind speed at observed height, CHANGE VALUE TO 10.07
zs = 10; % Observed height
rho = 1.2; % Density of air
TurbineHeight = 66.1; % CHANGE VALUE TO 66.1
BladeDiameter = 53.8; % CHANGE VALUE TO 53.8

%% Calculate the two points where the pressure needs to be calculated
TopOfTheTurbine = (TurbineHeight + BladeDiameter/2); % ADD /2
BottomOfTheTurbine = (TurbineHeight - BladeDiameter/2);

%% Wind speed at those two points
alpha = 0.5*(z0/10)^0.2; % CONSTANT 0.5
u_TopOfTheTurbine = us*(TopOfTheTurbine/zs)^alpha; % TIMES alpha
u_BottomOfTheTurbine = us*(BottomOfTheTurbine/zs)^alpha; % TIMES alpha

%% Pressure acting on those two points
p_TopOfTheTurbine = 4/9*rho*u_TopOfTheTurbine^2 % SHOULD BE 4/9
p_BottomOfTheTurbine = 4/9*rho*u_BottomOfTheTurbine^2 % SHOULD BE SQUARE

VariationOfPressure = p_TopOfTheTurbine - p_BottomOfTheTurbine