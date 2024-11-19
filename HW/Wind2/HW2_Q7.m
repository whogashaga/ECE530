%% Parameters
BladeLength = 48.43; % CHANE VALUE TO 48.43
c = 8.44; % average wind speed, CHANE VALUE TO 8.44
cp = 0.43; % power coefficient, CHANE VALUE TO 0.43
rho = 1.2;
a_square = pi/(4*c^2); % SHOULD BE a_square
area = pi*BladeLength^2;
%% Average power extracted by a single turbine
syms u;
fu = @(u) 2*a_square*u.*exp(-a_square.*u.^2); % SHOULD BE minus a_square
fplot(fu,[0,10]);    % Plot of fu (wind speed distribution)
P_wind = @(u) 0.5*rho*area*u.^3; % FIXED WIND SPEED DISTRIBUTED FUNCTION
fu_P_wind = @(u) fu(u).*P_wind(u);
p_avg_wind = integral(fu_P_wind, 0, inf); % INTEGRAL TO INFINITE
p_avg_wind_extracted = p_avg_wind * cp % TIMES cp
p_avg_wind_extracted_alternate = rho*area*2*c*sqrt(pi/(8*(a_square^(3/2))))*cp % FIXED THE FORMULA, MISSED c