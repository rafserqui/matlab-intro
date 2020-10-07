close all
clear all
clc

t0 = 0;
tf = 25;

% Parameters
theta = 0.95;
B = 1;
cbar = 0.85;
X = 1;
beta = 0.65;

% Steady-state (numerical and theoretical)
ss = (B.*(X.^(beta))./cbar).^(1./beta);
Lstar = fsolve(@(L)(ldot(1,L,theta,B,beta,X,cbar)),ss);


% Initial Conditions
L0 = [0.01;Lstar+(Lstar-0.01)];

% Numerical solution
[t,Lnumer] = ode45(@(t,L)ldot(t,L,theta,B,beta,X,cbar),[t0 tf], L0(1));

% Analytical solution
tl = linspace(t0,tf);

% Define constant
C1 = (-1./(beta.*theta.*cbar)).*(log(theta.*(X.^(beta)) - theta.*cbar.*(Lnumer(1).^(beta))));

% Define analytical solution
L_a1 = ((theta.*(X.^(beta))-exp(-(beta.*theta.*cbar).*(tl+C1)))./(theta.*cbar)).^(1./beta);

%--------------------------------------------------------------------------
% Second L0
%--------------------------------------------------------------------------
% Numerical solution
[t2,Lnumer2] = ode45(@(t,L)ldot(t,L,theta,B,beta,X,cbar),[t0 tf], L0(2));

% Analytical solution
% Define constant
% C2 = (-1./(beta.*theta.*cbar)).*(log(theta.*(X.^(beta)) - theta.*cbar.*(Lnumer2(1).^(beta))));
C2 = (theta.*(X.^(beta))-theta.*cbar.*Lnumer2(1).^(beta)).*exp(1./(beta.*cbar.*theta))
% Define analytical solution
L_a2 = ((theta.*(X.^(beta))-exp(-(beta.*theta.*cbar).*(tl+C2)))./(theta.*cbar)).^(1./beta);

figure
plot(t,Lnumer,'-o')
hold on
grid on
plot(tl,L_a1,'s')
plot(t2,Lnumer2,'-o')
plot(tl,L_a2,'-s')
plot(t,Lstar.*ones(length(t),1))
