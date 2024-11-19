%% Turbine power curve data
clc, clear all, close all
del_u = 0.5;
u = [0:del_u:25]';
P = [0
0
0
2
3
12
25
55
82
127
174
250
321
420
532
670
815
1000
1180
1380
1580
1690
1810
1900
1980
2030
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050
2050]*1000;
%% Plotting
figure
plot(u,P,'o')
legend('Wind turbine power curve')
ylabel('Power (kW)')
xlabel('Wind speed (m/s)')
%% Calculations
z0 = 0.001; % Surface roughness
us = 6; % Observed wind speed at observed height
zs = 10; % Observed height
turbineHeight = 85;
alpha = 0.5*(z0/10)^0.2;
u_turbineHeight = us*(turbineHeight/zs)^alpha; % FIXED FORMULA, divided by zs
c = 2*u_turbineHeight/sqrt(pi); % CONSTANT 2
Rayleigh = (2*u/c^2).*exp(-(u/c).^2);
P_avg = sum(P.*Rayleigh)*(del_u) % NOT SQUARE
CapacityFactor = P_avg/2050000
