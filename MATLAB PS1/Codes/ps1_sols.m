%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

This code shows the solutions to the first Matlab Problem Set.
%}

clear all
clc

%Ex.1
[sum,prod] = sumprodab(4,56)

%Ex.2
Aa = [2 1 -1; 2 -1 3; 3 -2 0];
ba = [-1;-2;1];

Ab = [2 3 0;3 -1 0;-3 1 1];
bb = [8;-2;0];

xa = Aa\ba
xb = Ab\bb

%Ex.3
my_ar1(0.7,0,100,0.65)

%Ex. 4
pg = 0.99;
Ng = 1000;
pp = 2;
Np = 200;
Gser = cumsum(pg.^(0:Ng));
Pser = cumsum(1./((1:Np).^pp));

Ginf = (1/(1-pg)).*ones(Ng+1,1);
Pinf = ((pi^2)/6).*ones(Np,1);

figure
plot((0:Ng),Gser,'-.','LineWidth',1.35)
hold on
grid on
plot((0:Ng),Ginf,'-k','LineWidth',1.35)
ylim([0 120])
legend('Finite Sum','Infinite Sum','Location','best')
ylabel('Sum')
xlabel('Elements in the Series')
title(['Convergence of Geometric Series with p = ', num2str(pg)])
print(gcf,'D:\Dropbox\TEACHING\Matlab Introduction\MATLAB PS1\Problem Set\geoseries','-depsc','','-r0')

figure
plot((1:Np),Pser,'-.','LineWidth',1.35)
hold on
grid on
plot((1:Np),Pinf,'-k','LineWidth',1.35)
ylim([1 2.2])
legend('Finite Sum','Infinite Sum','Location','best')
ylabel('Sum')
xlabel('Elements in the Series')
title(['Convergence of P-Series with p = ', num2str(pp)])
print(gcf,'D:\Dropbox\TEACHING\Matlab Introduction\MATLAB PS1\Problem Set\pseries','-depsc','','-r0')

%Ex. 5
my_fibonacci(10)

%Ex. 6
coefs = [2; 2; 2];
x = 2;
[poly_eval, derivative_coefs] = my_polynomial(coefs,x);

%Ex. 7
A0 = 1;
L0 = 1;
n  = 0.01;
delta = 0.75;
g  = 0.02;
s  = 0.35;
alpha = 1/3;
k0 = 5;
T  = 60;
[kk,Y,K,A,L] = solow(A0,L0,n,delta,g,s,alpha,k0,T);