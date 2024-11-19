%% Microgrid Simulation
% Created: ECE 530 class of fall 2024

clc
close all   % close figure windows
clear
format compact



%% Simulation settings

simu.endTime = 60*60*24;
simu.maxStepSize = 1e-1;



%% Data

load windspeedtimeseries

meanWindSpeed = 8;

% Scaling
windspeedtimeseries.Data = meanWindSpeed*windspeedtimeseries.Data;



%% Wind Turbine Parameters

wt.rho = 1.2; % Density of air kg/m^3

% XANT 100 kW
wt.Pgen_rated = 100e3;
wt.Cfric = 0.01*100e3/6^2;    % Nm/(rad/s)    B*6^2 = 0.01*100e3
wt.bladeLength = 11;
wt.bladeWeight = 1000;    % From http://windpower.sandia.gov/other/041605C.pdf
wt.J = 3*1/3*wt.bladeWeight*wt.bladeLength^2;  % Missing generator, gearbox, shaft, etc...

wt.A = pi*wt.bladeLength^2;

wt.w_0 = 0;

% Cp curve modeling
% lambdaai = 1/( (1/(lambda+0.08*beta)) - 0.035/(beta^3+1) )
% cp = c1*(c2/lambdaai-c3*beta-c4)*exp(-c5/lambdaai) + c6*lambda
plot_cp = 0;
if plot_cp
    wt.c = [
        0.5176
        116
        0.4
        5
        21
        0.0068
        ];
    figure
    lambda = [0:0.1:13];
    for beta = [0:5:30];
        lambdaai = 1./(1./(lambda+0.08*beta) - 0.035./(beta.^3+1));
        cp = wt.c(1)*(wt.c(2)./lambdaai - wt.c(3)*beta - wt.c(4)) .* exp(-wt.c(5)./lambdaai) + wt.c(6)*lambda;
        hold on
        plot(lambda,cp)
        hold off
    end
    axis([0 13 0 0.5])
    xlabel('lambda (tip speed ratio)')
    ylabel('Cp')
end

% From Cp(lambda) plot
wt.lambda_opt = 8.1;
wt.Cp_opt = 0.48;

% Region 2 and 3 boundary -> rated rotational speed and wind speed
wt.u_rated = (wt.Pgen_rated/(wt.Cp_opt*0.5*1.2*wt.A))^(1/3);   % P_rated = Cp_max*0.5*A*bladeLength*u_rated^3
wt.w_rated = wt.lambda_opt*wt.u_rated/wt.bladeLength;
wt.Tgen_rated = wt.Pgen_rated/wt.w_rated;

wt.pitchctrl.kp = 1;
wt.pitchctrl.ki = 0.1;
wt.pitchctrl.upperLimit = 1;
wt.pitchctrl.lowerLimit = 0;

disp("Good job!  The init file ran succesfully, hopefully the simulation does too.")