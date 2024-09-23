close all
clear
clc

% Parameters
gamm = 2.5;
p = 1.0;
w = 10.0;

% Define utility function
u = @(c) (c^(1 - gamm)) / (1 - gamm);

% Obviously, since the budget constraint must hold with equality, c = w / p.
cstar = w ./ p;

% Use fmincon to solve the problem

