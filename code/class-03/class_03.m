% =========================================================
%             === INTRODUCTION TO MATLAB ===
% =========================================================
% Rafael Serrano Quintero
% September 2021

% This code introduces the basics of root finding, numerical differentiation and integration.
% 
% Outline
% ---------------------------------------------------------------------------
% 1) Bisection method
% 2) Newton-Raphson method
% 3) Finite differences

close all
clear
clc

figs_folder = '../../notes/figures/';

%=================================================================
% BISECTION METHOD
%=================================================================
% Define f as an anonymous function
myf = @(x) x.^3 - 6.*x.^2 + 11.*x - 6;

% Plot the function on the interval [0,4] to see the behavior
xl = 0;
xr = 4;
xp = linspace(xl,xr,1000);

figure
plot(xp, myf(xp))
hold on
plot(xp, zeros(size(xp)))

% Focusing on [2.5, 4]
xl = 2.5;
xr = 4;

% Compute f(xl)f(xr)
disp(myf(xl).*myf(xr))

% === Bisection === %
it = 1;         % Iteration counter
delta = 1e-4;   % Tolerance for criterion 1
epsil = 1e-8;   % Tolerance for criterion 2

% Maximum number of iterations, note
Nmin = (log(xr - xl) - log(delta)) / log(2);
maxit = round(Nmin) + 50; % Minimum number plus some more

% Error parameters
error_f = 10;     % Initialize error for function (any number > delta)
error_i = (xr - xl) / (1 + abs(xl) + abs(xr));

disp('--------------------------')
disp('BISECTION METHOD')
disp('--------------------------')
while (error_f > delta) && (error_i > epsil) && (it < maxit)
    % Compute xm
    xm = xl + (xr - xl) / 2; % Avoids overflow that can happen sometimes

    % Compute value of f at xm
    fxm = myf(xm);

    % Compute bounds values of f
    fxl = myf(xl);
    fxr = myf(xr);

    % Compute errors
    error_f = abs(fxm);
    error_i = (xr - xl)./(1 + abs(xl) + abs(xr));

    disp(['Value of xM is ', num2str(xm)])
    disp(['Error of interval is ',num2str(error_i)])
    disp(['Error of function is ',num2str(error_f)])
    disp(['Iteration number ',num2str(it)])
    disp('--------------------------')

    % Update iteration counter
    it = it + 1;

    % Update if necessary
    if fxm*fxl < 0
        xr = xm;
    else
        xl = xm;
    end
end

disp(['BISECTION Solution is x* = ',num2str(xm)])

%=================================================================
% NEWTON-RAPHSON METHOD
%=================================================================
close all

% Define the derivative of the function fprime
fprime = @(x) 3.*x.^2 - 12.*x + 11;

% Re-initialize parameters
it = 1;         % Iteration counter
delta = 1e-4;   % Tolerance for criterion 1
epsil = 1e-8;   % Tolerance for criterion 2
maxit = 64;

% Error parameters
error_f = 10;     % Initialize error for function (any number > delta)
error_i = 10;

% Current guess
xk = 2.5;
disp('--------------------------')
disp('NEWTON-RAPHSON METHOD')
disp('--------------------------')
while (error_f > delta) && (error_i > epsil) && (it < maxit)
    % Compute next guess
    xkp = xk - myf(xk) ./ fprime(xk);
    
    % Compute the errors at current guess
    error_f = abs(myf(xk));
    error_i = abs(xk - xkp) ./ (1 + abs(xkp));

    % Inform about current situation
    disp(['Value of xkp is ', num2str(xkp)])
    disp(['Error of interval is ',num2str(error_i)])
    disp(['Error of function is ',num2str(error_f)])
    disp(['Iteration number ',num2str(it)])
    disp('--------------------------')

    % Update iteration counter
    it = it+1;

    % Update guess for xk
    xk = xkp;
end

disp(['NEWTON-RAPHSON Solution is x* = ',num2str(xk)])

% Illustrate problems of convergence
x = linspace(-1,1,100);

xk = 0.75;

figure
plot(x,x.^6,'-')
hold on

for it = 1:100
    xkp = xk - (x.^6)./(6.*(x.^5));
    plot(xkp, xkp.^6, 'dk')
end
legend('$f(x) = x^6$','$k = 100$','location','best','interpreter','latex')
print(sprintf('%snewton_convergence_issues',figs_folder),'-dpng','-r1080');
%}close all



%=================================================================
% NUMERICAL DIFFERENTIATION - FINITE DIFFERENCE
%=================================================================
N = 10;
x = linspace(-5,5,N);

hv = linspace(2,1e-2,8);

% Analytical derivative
fp_ana = fprime(x);

% Preallocation for numerical derivatives
dy = ones(length(hv), N);
dx = ones(length(hv), N);
fp_num = ones(length(hv), N);

leg = {'Analytical'};
cmap = parula(length(hv));

figure
plot(x,fprime(x),'-s','LineWidth',1.2)
hold on
for hh = 1:length(hv)
    h = hv(hh);
    
    % Numerical derivative
    dy(hh,:) = myf(x+h) - myf(x);
    dx(hh,:) = h.*ones(size(dy(hh,:)));
    fp_num(hh,:) = dy(hh,:)./dx(hh,:);
    
    plot(x,fp_num(hh,:),'--','Color',cmap(hh,:),'LineWidth',1.2)
    leg{hh+1} = ['$h = ',num2str(round(h,2)),'$'];
end
legend(leg,'location','NorthEast','interpreter','latex')
print(sprintf('%sfinite_differences',figs_folder),'-dpng','-r1080');
close all

% Solow example

s = 0.25;       % Savings rate
dp = 0.125;     % Depreciation rate
alp = 1/3;      % K share

k0 = 1;         % Initial capital
kss = (s./dp).^(1./(1 - alp));

% Finite difference solution
T = 70;                % Time horizon
npoints = 10;          % Number of points
h = T./npoints;        % Step size
k = zeros(npoints,1);
k(1) = k0;
for tt = 1:npoints-1
    k(tt+1) = k(tt) + h.*(s.*(k(tt).^(alp)) - dp.*k(tt));
end

% ODE45 Solution
tspan = linspace(1,T,npoints);
[t,ks] = ode45(@(t,kk) s.*(kk.^(alp)) - dp.*kk, tspan, k0);

% Analytical solution
tcont = linspace(0,T,1e3);
ktrue = (s./dp + (k0.^(1-alp) - s./dp).*exp(-dp.*(1 - alp).*tcont)).^(1./(1-alp));

figure
plot(tcont,ktrue,'-','LineWidth',1.6)
hold on
plot(tspan,k,'-s')
plot(tspan,ks,'-o')
plot(tspan,kss.*ones(npoints,1),'-r')
legend('True Solution','Finite Difference','ode45','Steady State','location','SouthWest')
print(sprintf('%ssolow_solution',figs_folder),'-dpng','-r1080');
close all

%=================================================================
% NUMERICAL INTEGRATION - MIDPOINT RULE
%=================================================================
% One point midpoint rule
a = 1;
b = 5;
fint = @(x)x.^2;
true_int = 124/3;

n = 1;
onep_int = midpoint_rule(a,b,n,fint);

% Multiple points
n = 5;
mpts_int = midpoint_rule(a,b,n,fint);

disp(['One point midrule value = ',num2str(onep_int),'. Abs diff = ',num2str(abs(true_int - onep_int))])
disp([num2str(n),' points midrule value = ',num2str(mpts_int),'. Abs diff = ',num2str(abs(true_int - mpts_int))])

% Check convergence with N
ni = 1;
Np = 60;
err_mp = ones(length(ni:Np),1);
count = 1;
for n = ni:Np
    tmp_val = midpoint_rule(a,b,n,fint);
    err_mp(count,1) = abs(true_int - tmp_val)./abs(tmp_val);
    count = count+1;
end

figure
stem(ni:Np,log10(err_mp))
xlabel('$n$','interpreter','latex','fontsize',14)
ylabel('$log_{10}(Error)$','interpreter','latex','fontsize',14)
print(sprintf('%serrors_midpointrule',figs_folder),'-dpng','-r1080');

close all
