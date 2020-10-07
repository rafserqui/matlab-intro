%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

This function plots two sinusoidal waves, one with frequency and amplitude
equal to 1 and another one that takes as inputs two scalars denoting
amplitude and frequency, and other two scalars denoting the range in which
we want to plot it.

A      = amplitude
freq   = frequency
lb     = lower bound for plot
ub     = upper bound for plot
%}

function [wave] = my_wave(A,freq,lb,ub)
    points = 10000;
    x = linspace(lb,ub,points);
    wave = A.*sin(freq.*x);
    
    figure
    plot(x,wave,'--','LineWidth',1.3)
    hold on
    grid on
    plot(x,sin(x),'-','LineWidth',1.3)
    legend({'$A\sin(\omega x)$','$\sin(x)$'},'Interpreter','latex','Location','best')
    xlabel('$x$','Interpreter','latex')
    title(['Sinusoidal wave with amplitude ', num2str(A), ' and frequency ', num2str(freq)])
end