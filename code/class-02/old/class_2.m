%{
Rafael Serrano Quintero
September 2021

This code shows the first commands and introduction to follow during the
class.

Outline
---------------------------------------------------------------------------
1) Import Data and Manipulation
2) Polynomial fit and Polynomial Evaluation
3) Non-Linear Least Squares
    3.1) Anonymous functions
4) Root Finding and Optimization
%}

clear
clc

%==========================================================================
                 % === Import Data and Manipulation === %
%==========================================================================
%{
We have data from the World Bank on real GDP per capita and urban
population as a % of total population.

Dataset includes country names and codes so we have mixed numerical and
text data. Format is Excel.

To avoid problems, I prefer to extract first the numerical data only and
then the text.
%}

gdp = xlsread('gdp_and_rural_pop.xlsx',1,'E2:BH218');
[num1,countries_gdp,raw1] = xlsread('gdp_and_rural_pop.xlsx',1,'C2:D218');
rural_pop = xlsread('gdp_and_rural_pop.xlsx',1,'E219:BH435');
[nums2,countries_rural,raw] = xlsread('gdp_and_rural_pop.xlsx',1,'C219:D435');

%{
This are two variables merged from WB database, countries in each variable
may not be the same, we need to check for that.

Check: strcmp
%}

true_tags = strcmp(countries_gdp,countries_rural);

if min(true_tags) == 1
    disp('Tags are equal. Delete and change name to countries')
    countries = countries_gdp;
    clear countries_gdp countries_rural
else
    disp('Tags for countries are not equal, check that!')
    return
end

%{
Suppose we want to make a projection of GDP and Urban Population growth for
every country. Suppose a 2% GDP growth and a 1.5% population growth.

But first, replace NaNs with 0 and add a row with the years at the
beginning.
%}

gdp(isnan(gdp)) = 0; % Replace NaNs

[CC, T] = size(gdp); % CC number of countries, T years
gdp(:,T+1) = gdp(:,T).*(1.02);
rural_pop(:,T+1) = rural_pop(:,T).*(1.015); 
time = 1960:2016;

gdp = [time;gdp];
rural_pop = [time;rural_pop];

%Let's drop now those countries that contain NaNs so we "clean" the data

%First, put back the NaNs
gdp(gdp==0) = NaN;

%{
Drop rows if they contain NaNs.

This is a single line but might be difficult to grasp. We are declaring a
new variable gdp_nonans as some subset of the variable gdp.

any(isnan(gdp),2) returns 1 (true) if any row (that's why the 2, second
dimension) contains at least one NaN. The ~ means "does not", so we are
declaring that we want those rows of gdp where NO NaNs appear, and all the
columns.
%}

gdp_nonans = gdp(~any(isnan(gdp),2),:);

% Find the country names
countries = [{'Country'},{'Code'};countries];
[countries_idx, cols] = find(~any(isnan(gdp),2));
countries_nonans = countries(countries_idx,1:2);

rurpop_nonans = rural_pop(countries_idx,:); % Take also rural pop

%Suppose we want to write this new matrix of GDP for countries without NaNs
%in a new Excel file
xlswrite('gdp_mod.xlsx', countries_nonans, 1)
xlswrite('gdp_mod.xlsx',gdp_nonans,1,'C1')

% Or in a .mat file (data file for MATLAB)
save('data_clean.mat','countries_nonans','gdp_nonans','rurpop_nonans')

% Clear everything and load a .mat file
clear
clc
load('data_clean.mat')

%{
Let's check the correlation between each country gdp per capita and its 
rural population.

First element of the vector of correlations is zero because we excluded the
first row (years).
%}

corr_coefs = ones(length(rurpop_nonans),1); % Preallocation for speed

for jj = 2:length(rurpop_nonans)
    corr_mat = corrcoef(gdp_nonans(jj,:),rurpop_nonans(jj,:));
    corr_coefs(jj,1) = corr_mat(1,2);
end

% Avg GDPpc vs Avg Rural population
avg_gdp_by_country = mean(gdp_nonans(2:end,:),2);
avg_rurpop_by_country = mean(rurpop_nonans(2:end,:),2);

figure
scatter(avg_rurpop_by_country,log(avg_gdp_by_country))
hold on
grid on
ylabel('Average GDP per capita by Country (in Logs)')
xlabel('Average Rural Population by Country (% over total population)')

%{
Something REALLY useful (and cool) is that MATLAB has a big commmunity of
users and people colaborate by creating functions that are not readily
implemented in MATLAB. You need to be careful with which functions you're
using and you should know what these functions do precisely.

Here I took a function lscatter that allows us to use labels for the data
points instead of simple circles.
%}

figure
lscatter(avg_rurpop_by_country,log(avg_gdp_by_country),countries_nonans(2:end,2))
hold on
grid on
ylabel('Average GDP per capita by Country (in Logs)')
xlabel('Average Rural Population by Country (% over total population)')

%{
The following lines show a bar plot that shows average GDPpc in each
country ordered from highest to lowest. Furthermore, it labels each bar
with the name of the country and plots it in full screen so that there is
no overlap in the labels.
%}

countries_nonans = countries_nonans(2:end,:); %Remove first line (titles)
[s_agdp, idx] = sort(avg_gdp_by_country,'descend');
cc_idx = countries_nonans(idx,:);

figure('units','normalized','outerposition',[0 0 1 1])
bar(s_agdp)
ylabel('Avg GDP')
xlabel('GDP per capita')
set(gca,'XTick',1:length(cc_idx),'XTickLabel',cc_idx(:,1),'XTickLabelRotation',90,'FontSize',8)

% Histogram
figure
histogram(avg_gdp_by_country,30)
ylabel('Number of Countries')
xlabel('GDP per capita')

%%
%==========================================================================
              % === Polynomial Fit and Polynomial Evaluation === %
%==========================================================================
close all
clear
clc

%{
Sometimes, it is useful to approximate functions with polynomials (you will
see more on this later on in this subject and in the 2nd year too). Matlab
has built-in functions to deal with this easily.

Suppose we have two variables X and Y that are related in some way that is
unknown to us and we want to approximate their relationship using an
n-degree polynomial.

To fit an n-degree polynomial, we use polyfit
%}

X = linspace(-1,1,1000);
Y = sin(5.5.*X.^2+2);

p4 = polyfit(X,Y,4);
p5 = polyfit(X,Y,5);
p6 = polyfit(X,Y,6);
p7 = polyfit(X,Y,7);

%Now let's plot the simulated data against the values predicted and resids

figure
subplot(3,1,1)
plot(X,Y,'o','MarkerSize',2)
hold on;
plot(X,polyval(p5,X),'-.','LineWidth',1.35)
plot(X,polyval(p6,X),'-','LineWidth',1.35)
plot(X,polyval(p7,X),'-','LineWidth',1.35)
legend('Data','5th Degree','6th Degree','7th Degree','Location','best')
title('Polynomial Fit of sin(5.5X+2)')
subplot(3,1,2)
plot(X,(polyval(p5,X)-Y).^2)
title('Residuals 5th Degree')
subplot(3,1,3)
plot(X,(polyval(p6,X)-Y).^2)
title('Residuals 6th Degree')

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

%%
%==========================================================================
                 % === Non-Linear Least Squares === %
%==========================================================================
%{
Suppose we have some non-linear model and we have data we want to fit to
that model. MATLAB directly provides us with two possible choices, they are
equivalent, because they both use the same algorithm. However, lsqcurvefit 
provides a more convenient way to write our functions when using data.

lsqcurvefit asks for the model you want to fit, lsqnonlin needs the
"residual" to be defined by the user and use this as the function to fit.

Notice both need initial values.

Supose we have a model like y = exp(beta*x), to test these two functions,
we are going to simulate the variables and try to fit the data. Suppose we
want 500 points, that our explanatory variable is x in [0,3] and y is
simulated using our model but adding a random number with std deviation of
0.05.
%}
close all
clear
clc

%Simulate data
P = 500;
beta = -1.3;
x = linspace(0,3,P);
y = exp(beta*x)+0.05*randn(1,P);

%{
Before going to the NLLS, let's introduce ANONYMOUS FUNCTIONS. It is
possible to declare functions within our script and without the need of
creating a script apart. These are functions that will be called only in
the script we write them (if you're familiar with Gauss, it works kind of
the same way).

The main difference between lsqcurvefit and lsqnonlin is the way in which
we write the functions. lsqcurvefit takes the function as it is, lsqnonlin
takes the "residual".
%}

% Declare anonymous functions with our model
fun_cfit = @(b,xdata)(exp(b(1)*xdata));
fun_nlin = @(b)(exp(b*x)-y);


% Fit
b00 = 5; % Initial condition
[bcfit,resnormcfit,rescfit,exitflagcfit,outputcfit] = lsqcurvefit(fun_cfit,b00,x,y);
[bnlin,resnormnlin,resnlin,exitflagnlin,outputnlin] = lsqnonlin(fun_nlin,b00);

figure
scatter(x,y)
hold on
grid on
plot(x,exp(x*bnlin),'-','LineWidth',1.35)
plot(x,exp(x*bcfit),'-','LineWidth',1.35)
legend('Data','lsqnonlin','lsqcurvefit')
xlim([0 3])
xlabel('x')
ylabel('$$exp(\beta x)$$','Interpreter','latex')

%%
%==========================================================================
                            % === Optimization === %
%==========================================================================
%{
MATLAB is capable of doing numerical optimization. Suppose we want to find
the roots of a function. The main solver for that is fzero. Let our
function be

y = cos(exp(x))+x^2-1

We will use an anonymous function to work with this.
%}
close all
clear
clc

myfun = @(x)(cos(exp(x))+x.^2-1);

figure
plot(-100:100,myfun(-100:100))

% Find roots
myfun_zeros = fzero(myfun,1);

% Minimize within an interval
myfun_minibnd = fminbnd(myfun,-10,10);

% Unconstrained minimization
myfun_miniunc = fminsearch(myfun,-10);
myfun_miniunc2 = fminunc(myfun,-10);

%{
Note that fminsearch and fminunc are two different methods of minimizing a
function. The first one is a derivative free solver and uses the
Nelder-Mead simplex direct search algorithm (don't ask me, I only know it
is good for complicated and even non-differentiable functions). The latter,
fminunc also does unconstrained optimization and allows you to use two
different algorithms (trust-region and quasi-newton).

They both have plenty of options and parameters you may want to play with
when you dont have to go through a master's degree. It is good that you
know they exist and that there will be problems in which some algorithms
work better than others. Up to this point, pick one and stick with it. if
it stops working, then you can worry about which solver to use.



Find the MAXIMUM of G(X) = cos(4x)sin(10x)e^{-abs(x)} in the range
[-pi,pi]. Use an anonymous function. Plot the function so 
that we can verify the minimum, highlight the minimum if possible.

It is a highly nonlinear function, so the choice of the initial value and
the solver matter a lot. To see that, check what happens when you change
b(2) to 10.
%}
clear
clc

b = [4;10];
gfun = @(x)(cos(b(1).*x).*sin(b(2).*x).*exp(-abs(x)));
gmsearch = fminsearch(@(x)(-cos(b(1).*x).*sin(b(2).*x).*exp(-abs(x))),-1);
gmuncons = fminunc(@(x)(-cos(b(1).*x).*sin(b(2).*x).*exp(-abs(x))),-1);
gmbounds = fminbnd(@(x)(-cos(b(1).*x).*sin(b(2).*x).*exp(-abs(x))),-pi,pi);
xplot = linspace(-pi,pi,1000);
gplot = gfun(xplot);

figure
plot(xplot,gplot)
hold on
grid on
plot(xplot,zeros(1,1000),'-k')
d1 = plot(gmsearch,gfun(gmsearch),'sr','MarkerFaceColor','r');
d2 = plot(gmuncons,gfun(gmuncons),'.k','MarkerSize',20,'MarkerFaceColor','k');
d3 = plot(gmbounds,gfun(gmbounds),'oc','MarkerFaceColor','c');
legend([d1 d2 d3],{'fminsearch','fminunc','fminbnd'},'Location','best')
xlim([-pi pi])
title('Graphical Maximum')
