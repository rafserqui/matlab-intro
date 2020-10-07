%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

A function that simulates an AR(1) process taking the coefficient, initial
values, length of the simulation, and std dev of the error term, and plots
the path.
%}

function [yt] = my_ar1(rho,y0,T,sigma)
y(1,1) = y0;


epsi = sigma.*randn(T,1);


for t=2:T
    y(t,:) = rho.*y(t-1,:)+epsi(t-1,:);
end

figure
plot(y,'-o','LineWidth',1.35)
grid on
hold on
xlim([1 T])
title(['Simulated AR(1) with \rho = ', num2str(rho), ' \sigma = ', num2str(sigma)])
end