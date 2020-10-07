%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

This code has the solutions for all the exercises of PS2 (calling the
functions). This code should be run by sections, each section corresponds
to an exercise of the PS.
%}

%===========================================================================
                        % === Chaotic Dynamics === %    
%===========================================================================
close all
clear all
clc

%First, test the function chaos
yy = chaos(0.6,3,50);

figure
plot(yy)

                % === Bifurcation Diagram === %

rho = 2.5;
T = 10000;
obs = 50;
step = 0.01;

figure
hold on;
while rho<=4
    %First simulate all the dynamics
    xx = chaos(0.5,rho,T);
    %Discard all observations but the last 50
    xx = xx(end-obs+1:end);
    
    %Plot the simulations
    plot(rho*ones(obs,1),xx,'b.')
    rho = rho+step;
end
grid on
title('Bifurcation diagram')
xlabel('\rho')
xlim([2.5 4.0])
hold off;
print(gcf,'D:\Dropbox\TEACHING\Matlab Introduction\MATLAB PS2\Problem Set\bifurc','-depsc','-r0')

%%
%==========================================================================
                    % === Ordinary Least Squares === %
%==========================================================================
%{
Simulate observations and estimate via OLS the simulated variables.

    - y = beta_1 + beta_2 x_2 + beta_3 x_3 + epsi_t
    - y = X*b (Matrix form)
    - x2 = trend variable (1,...,T) plus a shock u_t N(0,0.02)
    - x3 = random uniform on [3, 5]
    - espi_t = N(0,0.04)
    - beta_1 = 5, beta_2 = 1, beta_3 = 0.1
%}

close all
clear all
clc

%Parameters
%--------------------------------------------------------------------------
low_b = 3;
upper_b = 5;
beta1 = 5;
beta2 = 1;
beta3 = 0.1;
sigma_e = 0.04;
sigma_u = 0.02;
T = 100;

%Simulate explanatory variables
x2 = (1:T)'+sigma_u.*randn(T,1);
%To generate N random numbers in the interval (a,b), a + (b-a).*rand(N,1)
x3 = low_b+(upper_b-low_b).*rand(T,1);

%Alternatively, we could use a loop but it's less efficient.
%{
for t=1:T
    ushock(t,1) = sigma_u.*randn(t,1);
    x2(t,:) = t+ushock(t,1);
    %Another way of simulating a uniformly distributed variable
    x3(t,:) = unifrnd(low_b,upper_b);
end
%}

%Simulate dependent variable
X = [ones(T,1) x2 x3];    % Notice the column of ones to include a constant
b = [beta1 beta2 beta3]';
epsi = sigma_e.*randn(T,1);
y = X*b+epsi;

%Estimate y with observables x2 and x3
beta_hats = (X'*X)\X'*y;

%It is recommended to use backslash, anyways, we could use inv()
%{
beta_hats = inv(X'*X)*X'*y;
%}

%Check the absolute difference between the estimated beta and the true ones
diff_beta = abs(b-beta_hats);

%Compute and plot the residuals
ypred = X*beta_hats;
resid = y-ypred;

figure
plot(resid,'-.','LineWidth',1.35)
hold on
grid on
plot(zeros(T,1),'k-','LineWidth',1.5)
xlim([1,T])
title('Residuals')

figure
autocorr(resid) %ACF in case we would be worried about autocorrelation

%Plot the data generated against the estimate
figure
scatter3(x2,x3,y,'filled','MarkerFaceColor',[0.0 0.75 0.75])
hold on
x2fit = min(x2):2:max(x2);
x3fit = low_b:0.2:upper_b;
[X2FIT, X3FIT] = meshgrid(x2fit,x3fit);
YFIT = beta_hats(1)+beta_hats(2)*X2FIT+beta_hats(3)*X3FIT;
surf(X2FIT,X3FIT,YFIT,'FaceAlpha',0.75,'EdgeColor',[0.0,0.75,0.75],'FaceColor','interp')
xlabel('$$x_2$$','Interpreter','latex','FontSize',14)
ylabel('$$x_3$$','Interpreter','latex','FontSize',14)
zlabel('$$y$$','Interpreter','latex','FontSize',14)
print(gcf,'D:\Dropbox\TEACHING\Matlab Introduction\Notes\3dscatter','-depsc','-r0')
%%
%==========================================================================
                    % === Markov Chain Function === %
%==========================================================================
close all
clear all
clc

alpha = 1/3; % Prob of going from state 1 to 2
beta  = 1/4; % Prob of going from state 2 to 1

P = [1-alpha, alpha;beta, 1-beta]; % Stochastic Matrix
x0 = 1;                            % Start in state 1
T  = 30;                           % Periods
states = 2;                        % Number of states
xt = markov_chain(P,x0,T,states);  % Generate the sequence

figure
plot(1:T,xt)
grid on
title('Markov Chain')

%==========================================================================
                       % === Unemployment Model === %
%==========================================================================
close all
clear all
clc

%Parameters
%--------------------------------------------------------------------------
alpha = 0.25;
beta = 0.25;

T = 3000;
p = beta/(alpha+beta);

P = [1-alpha, alpha ; beta, 1-beta];
x0 = 1;
x1 = 2;

unemployed_series = markov_chain(P,x0,T,2);
employed_series = markov_chain(P,x1,T,2);

%Compute fraction of time unemployed at each point in time


for tt = 1:T
    if unemployed_series(tt,:) == 1
        xbar1_index(tt,1) = 1;
    else
        xbar1_index(tt,1) = 0;
    end
    
    if employed_series(tt,:) == 1
        xbar2_index(tt,1) = 1;
    else
        xbar2_index(tt,1) = 0;
    end
    
end

time = [1:T]';

x_bar1 = cumsum(xbar1_index)./time;
x_bar2 = cumsum(xbar2_index)./time;



figure
h3 = area(time,x_bar1-p,'FaceAlpha',0.15,'FaceColor',[0.4 0.8 0.6]);
hold on
grid on
h4 = area(time,x_bar2-p,'FaceAlpha',0.15,'FaceColor',[0.4 0.8 0.6]);
h1 = plot(time, x_bar1-p,'-.','LineWidth',1.35);
h2 = plot(time, x_bar2-p,'--','LineWidth',1.35);
plot(time, zeros(T,1),'k-','LineWidth',1.35)
legend([h1 h2], {'$$X_0 = 1$$','$$X_0 = 2$$'},'Interpreter','latex')
xlim([1 T])
print(gcf,'D:\Dropbox\TEACHING\Matlab Introduction\MATLAB PS2\Problem Set\unemployment_dynamics','-depsc','-r0')

%%
close all
clear all
clc

Yt = load('gdppcUSA.mat');% xlsread('gdppcUSA.xls',1,'B12:B295');
Yt = Yt.Yt;
T = length(Yt);

gy = log(Yt(2:end,:))-log(Yt(1:end-1,:));

% === Non-linear Fit === % (lsqcurvefit)
mod1 = @(phi,time)(exp(phi(1)*time+phi(2))); % Declare model
phi00 = [mean(gy);1];   % Initial Values
time = 1:T;
time = time';

[phi_m1,resnorm1,resids1,exitflag1,output1] = ...
    lsqcurvefit(mod1,phi00,time,Yt);   % Fit
Ypred = exp(phi_m1(1)*time+phi_m1(2)); % Predicted values

figure
plot(time,Yt,'-','LineWidth',1.15)
hold on
grid on
plot(time,Ypred,'--','LineWidth',1.15)
legend('Data','Best fit','Location','best')
xlim([1 T])
xlabel('Quarters')
ylabel('$$exp(\phi_1 t+\phi_2)$$','Interpreter','latex')
title(['\phi_1 = ', num2str(phi_m1(1),'%.4f, '), ' \phi_2 = ', num2str(phi_m1(2),'%.3f, ')])
print(gcf,'D:\Dropbox\TEACHING\Matlab Introduction\MATLAB PS2\Problem Set\exp_fit','-depsc','-r0')

% === Non-linear Fit === % (lsqnonlin)
%{
The only difference is the way in which we call the function. Here, we
should construct a function that is the "residual" and lsqnonlin will
minimize this residual. Actually, these two functions are equivalent.
%}

mod2 = @(phi)(exp(phi(1)*time+phi(2))-Yt); % Declare model
[phi_m2,resnorm2,resids2,exitflag2,output2] = lsqnonlin(mod2,phi00);
Ypred2 = exp(phi_m2(1)*time+phi_m2(2)); % Predicted values

figure
plot(time,Yt,'-','LineWidth',1.15)
hold on
grid on
plot(time,Ypred2,'--','LineWidth',1.15)
legend('Data','Best fit','Location','best')
xlim([1 T])
xlabel('Quarters')
ylabel('$$exp(\phi_1 t+\phi_2)$$','Interpreter','latex')
title(['\phi_1 = ', num2str(phi_m2(1),'%.4f, '), ' \phi_2 = ', num2str(phi_m2(2),'%.3f, ')])

%--------------------------------------------------------------------------
% 2.- AR(2) for the GROWTH RATE of GDP
%--------------------------------------------------------------------------
%{
First of all, please bare in mind this is just an exercise, it is NOT a
good way of trying to forecast GDP per capita. You'll see some methods in
the second year specifically for forecasting.


--------------------------------------------------------------------------
       2.1- AR(2) via OLS
--------------------------------------------------------------------------

Let's now estimate an AR(2) for the growth rate of the GDP per capita.
First, we will do this using simply OLS. Under Normality, OLS and MLE are
equivalent. The model is thus:

y_t = alpha + rho_1 y_{t-1} + rho_2 y_{t-2} + u_t

Note that to do OLS, the dependent variable is g_y from the 3rd observation
until the end, and the other two explanatory variables are g_y from the 2nd
observation until T-1, and g_y from the 1st observation until T-2.
%}

n = length(gy);
X = [ones(n-2,1) gy(2:end-1,1) gy(1:end-2)]; % Matrix of data
yy = gy(3:end,1);

bhat = X'*X\X'*yy;
% Alternatively -> bhat = inv(X'*X)*X'*yy;
yhatOLS = X*bhat;
uhat = yy-yhatOLS;
shat = (1/(n-4))*(uhat'*uhat);
Shat = shat*inv(X'*X);

% === Compare with mvregress === %
[bhat2,shat2,EE,Shat2] = mvregress(X,yy);

%{
--------------------------------------------------------------------------
       2.2- AR(2) via MLE
--------------------------------------------------------------------------

Now let's repeat the estimation but using MLE. We need to write the ML
function in a different script. Let's use the same matrix X as before and
the same explanatory variable y.

The use of globals is not usually recommended, but here it simplifies a
lot.
%}
close all

%Some cool options to see the iterations on parameters graphically
%We estimate the constant, the two autoregressive parameters, and the
%variance.
rhotilde = [1 0.5 0.5 0.2]';
options = optimset('PlotFcns',@optimplotx,'DISPLAY','iter','TolFun',1e-10, 'MaxFunEvals',20000);
[bmle,likelihood]=fminunc(@(rho)my_mle(rho,X,yy), rhotilde, options);
yhatMLE = X*bmle(1:3);

figure
plot(1:n-2,yy,':','LineWidth',0.85)
hold on
grid on
plot(1:n-2,yhatOLS,'--','LineWidth',1.25)
plot(1:n-2,yhatMLE,'-.','LineWidth',1.25)
xlim([1 length(yy)])
xlabel('Time')
ylabel('Growth Rate of GDP per Capita')
legend('Data','AR(2) OLS', 'AR(2) MLE')
title(['\rho^{OLS}_1 = ', num2str(bhat(2),'%.2f, '), ' \rho^{OLS}_2 = ', num2str(bhat(3),'%.2f, '), ' \rho^{MLE}_1 = ', num2str(bmle(2),'%.2f, '), ' \rho^{MLE}_2 = ' num2str(bmle(3),'%.2f ')])

%{
% Matlab has built-in functions for ARIMA models of any kind. To fit this
% model we can use the following lines. The estimates are the same.

model_arma = arima(2,0,0);
est = estimate(model_arma,gy);
ar_coefs = est.AR;
ma_coefs = est.MA;

resi = infer(est,g_y);
ypred = g_y-resi;
%}