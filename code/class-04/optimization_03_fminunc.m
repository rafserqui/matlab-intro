% =========================================================
%             === INTRODUCTION TO MATLAB ===
% =========================================================
% Rafael Serrano Quintero
% September 2021
%
% Illustration of fminunc with the Rosenbrock function 
close all
clear
clc

% Optimize the Rosenbrock function
% Initial point
x0 = [14, 4];

% Optimization call (no gradient)
[xng, fvalng] = fminunc(@(x)rosenbrock(x),x0);

% Add options
opts = optimoptions('fminunc','Algorithm','trust-region',...
                        'SpecifyObjectiveGradient', true);
[xg, fvalg] = fminunc(@(x)rosenbrock(x),x0,opts);

% Compare with / without gradient
norm(xng - xg)
disp('f(x)')
disp(['No gradient ', ' Gradient'])
disp([fvalng, fvalg])

% Parsing other parameters to the function
a = 2;
b = 200;
[xpar, fvalpar] = fminunc(@(x)rosenbrock(x,a,b),x0, opts);