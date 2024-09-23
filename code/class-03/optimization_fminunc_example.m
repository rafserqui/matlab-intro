close all
clear
clc

fmin = @(x) (x.^2 ./ 2) - log(x.^2);

% Plot the function
xp = linspace(-5, 5, 1000);
xminpos = sqrt(2);
xminneg = -sqrt(2);

figure
plot(xp, fmin(xp))
hold on
plot(xminpos, fmin(xminpos), 'or', 'MarkerFaceColor', 'r')
plot(xminneg, fmin(xminneg), 'or', 'MarkerFaceColor', 'r')

% Find the minimum
x0 = 1;
[xmin1, fval1] = fminunc(@(x) fmin(x), x0);

% Changing the initial guess, will change the minimum
x0 = -1
[xmin2, fval2] = fminunc(@(x) fmin(x), x0);

% Add options, maybe more detail in each iteration
opts = optimoptions('fminunc', 'Display', 'iter', 'OptimalityTolerance', 1e-10); 
[xmin2, fval2] = fminunc(@(x) fmin(x), x0, opts);
