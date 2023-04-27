close all
clear
clc

% Define function
u = @(x) x(1) - 0.05.*x(1).^2 + log(x(2)) - 0.25 - (x(1) - 20).^2 + (x(2) - 20).^2;

% Define grid
np = 1000;
lgrid = linspace(0, 100, np);
kgrid = lgrid;

% Maximize using fminsearch
x0 = [1,1];
[xopt, fval] = fminsearch(@(x) -u(x), x0);


% Use fmincon to add the budget constraint
