%% Parameters
BladeLength = 48.43; % CHANE VALUE TO 48.43
c = 8.44; % average wind speed, CHANE VALUE TO 8.44
cp = 0.43; % power coefficient, CHANE VALUE TO 0.43
rho = 1.2;
a2 = pi/(4*c^2);
area = pi*BladeLength^2;
del_u = 0.5;
%% Average power extracted by a single turbine
syms u;
fu = @(u) 2*a2.*u.*exp(a2.*(u^2)); 
fplot(fu,[0,10]);    % Plot of fu (wind speed distribution)
P_wind = @(u) 0.5*rho*area*u.^3; 
fu_P_wind = @(u) fu(u).*P_wind(u);
p_avg_wind = integral(fu_P_wind, 0, inf);
p_avg_wind_extracted = p_avg_wind * del_u
p_avg_wind_extracted_alternate = rho*area*2*sqrt(pi)/(8*a2^(3/2))*cp