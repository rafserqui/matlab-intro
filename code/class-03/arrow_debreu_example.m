close all
clear 
clc 

% Start by defining parameters
alpha = 0.6;
beta  = 0.4; 

omega1A = 10;
omega2A = 15;

omega1B = 15;
omega2B = 10;

% Suppose we guess p1 is 0.5, what is the excess demand?
z1 = excess_demand_good1(0.5,omega1A,omega1B,omega2A,omega2B,alpha,beta);
disp(z1)

% Since there is excess demand for good 1, it means it is "too cheap", we must increase its price
z1 = excess_demand_good1(2,omega1A,omega1B,omega2A,omega2B,alpha,beta);
disp(z1)

% Now the excess demand is negative, which means good 1 is "too expensive"

% Let's try to find the solution using Matlab
p1_ini = 0.7;
[p1_opt, excess_demand] = fzero(@(x) excess_demand_good1(x,omega1A,omega1B,omega2A,omega2B,alpha,beta), p1_ini);

% Define the analytical solution of p1
p1_star = (alpha.*omega2A + beta.* omega2B) ./ ((1 - alpha) .* omega1A + (1 - beta).* omega1B);

disp("Difference between analytical and numerical solutions")
disp(abs(p1_star - p1_opt))

% Compute now the optimal demands of each good:
ma = p1_star .* omega1A + omega2A;
mb = p1_star .* omega1B + omega2B;
x1a = alpha .* (ma / p1_star);
x2a = (1 - alpha) .* ma;

x1b = beta .* (mb / p1_star);
x2b = (1 - beta) .* mb;

% We have found the equilibrium using z1, can you find the same equilibrium by using z2 instead?
