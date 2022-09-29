close all
clear
clc

rosenbrock2d = @(x, y) (1 - x).^2 + 100.*(y - x.^2).^2;

P = 500;
dom = linspace(-1.5, 1.5, P);
[X, Y] = meshgrid(dom, dom);

Z = rosenbrock2d(X, Y);

figure
mesh(X, Y, Z)