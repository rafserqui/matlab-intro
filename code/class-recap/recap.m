close all
clear
clc


%======================================
% Matrix and Element-wise Operators
%======================================
A = [1 2 3;
    4 5 6;
    7 8 9];
B = randi(100,3);

disp('A = ')
disp(A)
disp('B = ')
disp(B)
disp('Matrix product:')
disp(A*B)
disp('Element-wise Product:')
disp(A.*B)

disp('Matrix exponential:')
disp(A^2)
disp('Element-wise exponential')
disp(A.^2)

%====================================
% Anonymous functions
%====================================
myfun = @(p,x) p(1).*x.^2 + p(2).*x + p(3);
b = [2,1,-6];
fx0 = myfun(b,0);
xlin = linspace(-3,3,100);
fx = myfun(b,xlin);

figure
plot(xlin,fx)

%====================================
% User-defined functions
%====================================
xstar = solution_sencond_degree(b);
disp(xstar)

%====================================
% Linear systems of equations
%====================================
A = [3, 4, 1;
    2, 2, -8;
    -4, 1, 0];
b = [0;1;0];
xstar = A\b;
disp(xstar)

%====================================
% For loops
%====================================
% The most inefficient way of counting until T
T = 100;
x0 = 0;
for it = 1:T
    x0 = x0 + 1;
end

% Preallocation
N = 1e9;
tic
x = 0;
for k = 2:N
   x(k) = x(k-1) + 5;
end
toc

tic
x = zeros(N,1);
for k = 2:N
    x(k) = x(k-1) + 5;
end
toc

%=============================
% Problems
%=============================
% Problem 1
% Write a function script for a CRRA utility function i.e.
% (c^{1-gamma} - 1)/(1 - gamma)
% and plot the consumption curves for gamma = {1.1,2,5,10}


% Problem 2
% Produce N random numbers and compute the average. Repeat M times 
% to get M averages and plot a histogram


% Problem 3
% Simulate a random walk with drift i.e.
% x_t = \mu + x_{t-1} + epsi
% and plot it.


% Problem 4
% Download the Penn World Tables and plot the labor share of income
% for the United States and your country of origin. If your country
% of origin is US, then do it for the US and Spain.


% Problem 5
% Fit a linear regression of
% LSH_{t} = alpha + beta*year + epsi
% where LSH is the labor share of the 
% country different from the US. Is it
% consistent with a model with a Cobb-Douglas
% production function?
