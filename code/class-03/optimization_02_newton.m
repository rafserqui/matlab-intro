%{
Rafael Serrano Quintero
September 2021

This code introduces Newton-Raphson's method to compute a minimum.
%}

close all
clear 
clc

fun = @(x) (x.^2)./2 - log(x.^2);
fpr = @(x) x - (2./x);
fppr = @(x) 1 + 2./(x.^2);

xtmin = sqrt(2);

x0 = 0.001; % point b in bracketing

delt = 1e-12;
epsi = 1e-10;
dint = 1000;
dfoc = 1000;
maxit = 1e5;
it = 1;

xp = linspace(-5,5,1000);
cmap = lines(5);
figure
plot(xp,fun(xp))
hold on
disp(['x0 = ', num2str(x0)])
while ((dint > epsi) || (dfoc > delt)) && (it < maxit)
    % Iteration scheme
    x1 = x0 - fpr(x0)./fppr(x0);

    scatter(x0,fun(x0),'filled','MarkerFaceColor',cmap(3,:))
    pause(1)
    % Distance measures
    dint = abs(x0 - x1)./(1 + abs(x0));
    dfoc = abs(fpr(x0));

    disp('-----------------------------')
    disp(['Iteration ', num2str(it)])
    disp(['x1 = ', num2str(x1)])
    disp(['dint = ', num2str(dint)])
    disp(['dfoc = ', num2str(dfoc)])
    % Update guesses
    x0 = x1;
    it = it + 1;
end
scatter(xtmin,fun(xtmin),'d','filled',...
        'MarkerFaceColor',cmap(2,:),'MarkerEdgeColor','black')
scatter(-xtmin,fun(-xtmin),'d','filled',...
        'MarkerFaceColor',cmap(2,:),'MarkerEdgeColor','black')

norm(xtmin - x0)
