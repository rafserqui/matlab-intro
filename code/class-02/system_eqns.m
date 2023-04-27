close all
clear
clc

% Parameters of the system
a = [9; 6; 0.04; 0.01; 0.01; 500];

x0 = [1,1];
xopt = fsolve(@(x) system_focs(x,a), x0);
