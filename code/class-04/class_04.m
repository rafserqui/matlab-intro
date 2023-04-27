%{
Rafael Serrano Quintero
September 2021

This code shows deals with importing and manipulating data first, and with data fitting later. We cover linear and nonlinear regression.

Outline
---------------------------------------------------------------------------
1) Import Data and Manipulation
2) Polynomial fit and Polynomial Evaluation
3) Non-Linear Least Squares
    3.1) Anonymous functions
%}

close all
clear
clc

%===============================================================
% 1) Import Data and Manipulation
%===============================================================
% Importing data from CSV file
gdp = readtable('./data/real_gdp_percapita.csv','ReadVariableNames',true);
pop = readtable('./data/urban_pop.csv','ReadVariableNames',true);

% Extract CountryCode for both files
ccode_gdp = table2cell(gdp(:,2));
ccode_pop = table2cell(pop(:,2));

% Compare strings one by one
compare_ccode = strcmp(ccode_gdp,ccode_pop);
all_true = all(compare_ccode);
disp(all_true)

% Extract GDP per capita and urban population as a matrices
gdp_pc = table2array(gdp(:,5:end))';
pop_ub = table2array(pop(:,5:end))';

% Explore the relationship between GDPpc and Urban population
figure
scatter(log(gdp_pc(:)),pop_ub(:),'filled','MarkerFaceAlpha',0.25)
lsline

% Pooled correlation
disp(corrcoef(log(gdp_pc(:)),pop_ub(:),'Rows','complete'))

% Correlation by country
[T, N] = size(gdp_pc); % Time periods (T) and number of countries (N)

corr_coefs = zeros(N,1);
for n = 1:N
    tmp = corrcoef(log(gdp_pc(:,n)),pop_ub(:,n),'Rows','Complete');
    corr_coefs(n,1) = tmp(1,2);
end

% Average correlation
mean(corr_coefs,'omitnan')
std(corr_coefs,'omitnan')

% Plot the evolution for India
years = 1960:1960+T-1;
india = strcmp(ccode_gdp,'IND');
gdp_india = gdp_pc(:,india);
urb_india = pop_ub(:,india);

figure
plot(years,gdp_india,'-o')
hold on
yyaxis right
plot(years,urb_india,'-s')
saveas(gcf,'../../notes/figures/india_gdp_urb.png')

% Relation for average (over time) GDPpc and Pop
figure
scatter(mean(log(gdp_pc),'omitnan'),mean(pop_ub,'omitnan'),...
            'filled','MarkerFaceAlpha',0.35)

%===============================================================
% 2) Fitting Data 
%===============================================================
% Reshape GDPpc matrix into a vector
y = reshape(gdp_pc,[T*N,1]);
y = log(y);     % Recall our dependent variable is in logs!

% Reshape pop_ub in the same way
urb_vect = reshape(pop_ub,[T*N,1]);

% Create the time trend
years_mat = repmat(years,N,1);
years_mat = years_mat';
years_vec = reshape(years_mat,[T*N,1]);

% Alternatively, with a bit of matrix algebra
% ymat = (ones(N,1)*years)';
% ymat = ymat(:);

% Remove missing values from both variables
miss_y = isnan(y);
miss_u = isnan(urb_vect);
tot_miss = logical(miss_y + miss_u);

y_clean = y(~tot_miss);
u_clean = urb_vect(~tot_miss);
years_clean = years_vec(~tot_miss);

% Create matrix X
X = [ones(size(u_clean)), u_clean, years_clean];

% Estimate bhat
bhat = ((X')*X)\((X')*y_clean);
disp(bhat)

% Alternatively:
% bhat = (((X')*X)^(-1))*(X')*y_clean;
% but this is the same as inv(A)*b. The recommended way is with \

%=============================================
% fitlm
%=============================================
% Control variables
Xfitlm = [urb_vect, years_vec];

% Model object
linmodel = fitlm(Xfitlm,y);
disp(linmodel)

% Diagnostics
plotResiduals(linmodel)
plotResiduals(linmodel,'fitted')
plotEffects(linmodel)
plotAdded(linmodel)

%=============================================
% polyfit and polyval
%=============================================
close all
clear
clc

% Simulate variables and their relationship
x = linspace(-1,1,1000);
y = sin(5.*x.^2 + pi);

% Fit 5,6,7th degree polynomials
p5 = polyfit(x,y,5);
p6 = polyfit(x,y,6);
p7 = polyfit(x,y,7);

figure
plot(x,y,'-','LineWidth',2)
hold on
plot(x,polyval(p5,x),'-','LineWidth',1.35)
plot(x,polyval(p6,x),'--','LineWidth',1.35)
plot(x,polyval(p7,x),'-.','LineWidth',1.35)
legend('Data','5th Degree', '6th Degree', '7th Degree', 'location', 'best')
saveas(gcf,'../../notes/figures/poly_fit.png')

%PROPOSED EXERCISE
%--------------------------------------------------------------------------
%{
Simulate a variable X in the interval [-4,4] with 1000 points. Generate a
variable Y = X^2 + epsilon where epsilon is white noise with standard 
deviation 1.5. Fit a second degree polynomial and plot the simulated data
and the fitted polynomial on the same plot.
%}


X = linspace(-4,4,1000);
Y = X.^2 + 1.5.*randn(1,length(X));
p2 = polyfit(X,Y,2);

figure
scatter(X,Y)
hold on
plot(X,polyval(p2,X),'-','LineWidth',1.35)
title('Polynomial Fit')

%==========================================================================
                 % === Non-Linear Least Squares === %
%==========================================================================
close all
clear
clc

%Simulate data
N = 500;
b1 = 2;
b2 = -1.5;
x = linspace(0,5,N);
y = b1*exp(b2*x)+0.15*randn(1,N);

% Declare anonymous function with our model
func_fit = @(b,xdata)(b(1)*exp(b(2)*xdata));

% Fit
b00 = [1, -1]; % Initial condition
[bhat,resnorm,res,exitflag,output,lamb,jacob] = lsqcurvefit(func_fit,b00,x,y);

% Compute confidence intervals
ci = nlparci(bhat,res,'Jacobian',jacob);

% Compute standard errors
stderr = (ci(:,2) - ci(:,1))./3.92;

% Alternatively
fit_nlin = fitnlm(x,y,func_fit,b00);

% Predicted values
yhat = bhat(1).*exp(bhat(2).*x);

figure
scatter(x,y,'filled','MarkerFaceAlpha',0.35)
hold on
plot(x,yhat,'-','LineWidth',1.5)
legend('Data','Best Fit')
saveas(gcf,'../../notes/figures/lsqcurvefit_performance.png')