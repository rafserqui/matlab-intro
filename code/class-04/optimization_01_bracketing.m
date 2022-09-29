%{
Rafael Serrano Quintero
September 2021

This code introduces the bracketing method to compute a minimum.
%}

close all
clear 
clc

fun = @(x) (x.^2)./2 - x;
xtmin = fminsearch(fun, 15);

xp = linspace(-5,5,1000);

figure
plot(xp,fun(xp))

% Parameters of bracketing method
h = 1e-2;
alp = 1.1;

% Step 1 - Initial bracketing
x0 = -5;
fx0 = fun(x0);
x1 = x0 + alp*h;
fx1 = fun(x1);

% If function is increasing in this direction, change direction
if fx1 > fx0
    h = -h;
end

condition = true;
it = 1;
while condition
    if h < 0
        x2 = x0 + alp*h;
    else
        x2 = x1 + alp*h;
    end
    fx2 = fun(x2);

    if h < 0
        if fx2 > fx0
            a = x2;
            b = x0;
            c = x1;
            condition = false;
        end
    else
        if fx2 > fx1
            a = x0;
            b = x1;
            c = x2;
            condition = false;
        end
    end

    alp = alp*2;

    it = it+1;
end

fa = fun(a);
fb = fun(b);
fc = fun(c);

% Refine the intervals
difference = 100;
tol = 1e-10;
it = 1;
maxit = 1e5;
while (difference > tol) && (it < maxit)
    % Step 2: define d and compute f(d)
    if (b - a) > (c - b)
        d = (a + b)/2;
    else
        d = (b + c)/2;
    end
    fd = fun(d);

    % Step 3: refine the interval
    if d < b
        if fd > fb
            a1 = d;
            b1 = b;
            c1 = c;
        else
            a1 = a;
            b1 = d;
            c1 = b;
        end
    else
        if fb < fd
            a1 = a;
            b1 = b;
            c1 = d;
        else
            a1 = b;
            b1 = d;
            c1 = c;
        end
    end
    a = a1;
    b = b1;
    c = c1;

    % Recompute function values
    fa = fun(a);
    fb = fun(b);
    fc = fun(c);

    % Compute difference again
    difference = c - a;
    it = it + 1;
end

xmin = (c+a)/2;

abs(xmin - xtmin)