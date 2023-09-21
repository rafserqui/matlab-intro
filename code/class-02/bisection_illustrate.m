close all
clear
clc

% Define the function
f = @(x) x.^3 - 5*x + 1;

% Define the interval [a, b] where the root exists
a = -0.5;
b = 0.5;
xp = linspace(-1, 1, 1000);
root = fzero(f, 0);

% Tolerance (desired accuracy)
tol = 1e-6;

% Maximum number of iterations
maxit = 100;

% Initialize variables
xl = a;
xr = b;
iter = 1;

% Bisection method implementation
figure
plot(xp, f(xp))
hold on
grid on;
plot(xp, zeros(size(xp)), '-k')
plot(a, f(a), 'or', 'MarkerFaceColor', 'r')
plot(b, f(b), 'or', 'MarkerFaceColor', 'r')
xline(a, '--')
xline(b, '--')
plot(root, f(root), 'o', 'MarkerFaceColor', '#006633')
xlabel('x');
ylabel('f(x)');
title('Bisection Method Illustration');
while (iter <= maxit)
    xm = xl + (xr - xl) ./ 2;
    fxm = f(xm);
    
    plot(xm, fxm, 'o', 'Color', '#A0A0A0', 'MarkerFaceColor', '#A0A0A0');
    plot(root, f(root), 'o', 'Color', '#006633', 'MarkerFaceColor', '#006633')
    pause(0.5)
    if abs(fxm) < 1e-3
        xlim([0.19, 0.21])
    end

    fprintf('Value of xm: %.4f\n', xm)
    fprintf('Value of f(xm): %.4f\n', fxm)

    % Compute bounds
    fxl = f(xl);
    fxr = f(xr);

    if (abs(fxm) < tol)
        fprintf('Bisection method converged after %d iterations.\n', iter);
        fprintf('Approximate root: %.6f\n', xm);
        break;
    end
    
    if (fxl * fxm < 0)
        xr = xm;
    else
        xl = xm;
    end
    
    iter = iter + 1;
end
