%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

This function solves the Solow growth model, plots the convergence to the
steady state of the capital stock, the path for output, and the Solow
diagram.

Inputs:
---------------------------------------------------------------------------
A0      Initial productivity level
L0      Initial population level
n       Population growth rate
delta   Depreciation rate
g       Technology growth rate
s       Savings rate
alpha   Capital share of income
k0      Initial capital stock
T       Time horizon

Outputs:
---------------------------------------------------------------------------
kk      Capital stock in efficiency terms
Y       Output
K       Capital
A       Technology levels
L       Population levels
%}
function [kk,Y,K,A,L] = solow(A0,L0,n,delta,g,s,alpha,k0,T)
    
    time = 1:T;
    
    % Steady State value for K
    kss = ((s/(n+g+delta)).^(1/(1-alpha))).*ones(T,1);
    
    kk =  k0.*ones(T,1);
    A = A0.*(1+g).^((1:T)');
    L = L0.*(1+n).^((1:T)');
    % Recursive Series of K
    for tt=2:T
        kk(tt,1) = s.*kk(tt-1,1).^(alpha)+(1-n-g-delta).*kk(tt-1,1);
    end
    
    K = kk.*A.*L;
    Y = K.^(alpha).*(A.*L).^(1-alpha);
   
    figure
    plot(time, kk,'-o','LineWidth',1.25)
    hold on
    grid on
    plot(time,kss,'-','LineWidth',1.35)
    legend('Capital Stock','Capital Steady State','Location','best')
    title('Convergence to the Steady State')
    
    figure
    plot(time,Y,'-o')
    grid on
    title('Output Growth')
    
    % === Solow Diagram === %
    kd = linspace(0,3.*kss(1,1),1000);
    inv = s.*kd.^(alpha);
    dep = (n+g+delta).*kd;
    yd  = kd.^(alpha);
    
    figure
    plot(kd,inv,'-','LineWidth',1.35)
    hold on
    grid on
    plot(kd,dep,'--','LineWidth',1.35)
    plot(kd,yd,'-','LineWidth',1.35)
    plot(kss(1,1), kss(1,1).^(alpha),'.k','MarkerSize',20)
    plot(kss(1,1), s.*kss(1,1).^(alpha),'.k','MarkerSize',20)
    line([0,kss(1,1)],[s.*kss(1,1).^(alpha),s.*kss(1,1).^(alpha)],'Color','k')
    line([kss(1,1),kss(1,1)],[0,kss(1,1).^(alpha)],'Color','k')
    text(kd(end),inv(end),'$sk^{\alpha}$','Interpreter','latex','FontSize',12)
    text(kd(end),dep(end),'$(n+g+\delta)k$','Interpreter','latex','FontSize',12)
    text(kd(end),yd(end),'$y = k^{\alpha}$','Interpreter','latex','FontSize',12)
end