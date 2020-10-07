% =========================================================================
%             === Solving the Stochastic Neoclassical Model === 
% =========================================================================
% Rafael Serrano Quintero
% QED MACROECONOMICS III 2018

% The first line of a Dynare code is always declaring the variables of the 
% model. This is done with command var. 

% ALL LINES IN DYNARE NEED TO END WITH SEMICOLON (;) OTHERWISE YOU'LL GET AN
% ERROR

var y I k a c w r;

% Declare exogenous variables (varexo). Technology shock's disturbance

varexo e;

% To declare parameters, first you tell Dynare which are these and then, 
% you give values.

parameters alpha beta delta rho sig sige;

alpha = 1/3;
beta = 0.99;
delta = 0.025;
rho = 0.95;
sig = 1;
sige = 0.01;

% The next block is the model block. Here just type the model as you would 
% write it by hand. The important thing here is how to write the time of 
% the variables.
% 
%     - If x is at t-1, then write x(-1)
%     - If x is at t, then write x
%     - If x is at t+1, then write x(+1)
%     
% However, recall that predetermined variables (like the capital stock) 
% should be declared "lagged". The block of the model starts with "model;" 
% and finishes with "end;"

model;
    c^(-sig) = beta*(c(+1)^(-sig)*(alpha*a(+1)*k^(alpha-1)+1-delta));
    k = (1-delta)*k(-1)+a*k(-1)^(alpha)-c;
    log(a) = rho*log(a(-1)) + e;
    y = a*k(-1)^(alpha);
    I = y-c;
    r = alpha*a*k(-1)^(alpha-1);
    w = (1-alpha)*a*k^(alpha);
end;

% Assume now that we want to take a Taylor series expansion in logs rather 
% than in level. This is useful to interpret IRFs in percentages. We just 
% rewrite the model as
% 
% model;
%     exp(c)^(-sig) = beta*(exp(c)(+1)^(-sig)*(alpha*exp(a(+1))*exp(k)^(alpha-1)+1-delta));
%     exp(k) = (1-delta)*exp(k(-1))+exp(a)*exp(k(-1))^(alpha)-exp(c);
%     a = rho*a(-1) + e;
%     exp(y) = exp(a)*exp(k(-1))^(alpha);
%     exp(I) = exp(y)-exp(c);
%     exp(r) = alpha*exp(a)*exp(k(-1))^(alpha-1);
%     exp(w) = (1-alpha)*exp(a)*exp(k)^(alpha);
% end;

% Dynare will solve for the steady state numerically (you can also provide a 
% steady state file, but this is not in the scope of this class). To do that
% we need to provide initial values for this steady state as close as
% possible to the "true" steady state, if this initial value is too far from
% the true one, Dynare probably won't converge to a solution. Keep in mind
% how Dynare treats variables.
% 
% This is initialized with the block starting with "initval;" and "end;".

initval;
    k = 30;
    y = 3;
    c = 2.5;
    I = 0.5;
    a = 1;
    r = (1/beta)-1+delta;
    w = 1;
end;

% Now we need to specify a value for the variance of the shocks. For that, 
% include another block that starts with "shocks;" and finishes with "end;"
% If you include several shocks in your model, this block also allows you 
% to add correlations between the innovations of the shocks. You can declare
% a full variance-covariance matrix.

shocks;
    var e = sige^2;
end;

% To compute the steady state numerically of the endogenous variables, we 
% have to declare the command "steady;"

steady;

check; 

% We have all we need to simulate the model forward. This is done with the
% command stoch_simul. By default, this command reports coefficients of the
% approximated policy functions, moments of the variables, and IRFs for each
% shock. It also reports by default the steady state values of endogenous
% variables, the type of variables we have, the covariance matrix of shocks.
% 
% The default solution procedure by Dynare is a second order approximation.
% This involves cross-terms and thus, the policy functions will be more
% complex.
% 
% There are several interesting options that we can use.
%     1.- hp_filter = N. This reports moments and statistics of the data
%     AFTER HP filtering. N is the integer that gives value for the smoothing
%     parameter of the filter.
%     
%     2.- irf = N. In the IRFs plots it plots N periods. To suppress IRFs
%     figures just set N=0.
% 
%     3.- order = 1,2, or 3. The order of the approximation. The default is a
%     2nd order approximation.
% 
%     4.- periods = N. By default, Dynare will produce analytical or
%     theoretical moments of variables. If, instead, we want to simulate
%     data and compute the moments for that simulated data, we just need to
%     set N different from 0. If you use this option, N > 100 because Dynare
%     drops the first 100 terms. This is done to reduce the effect of initial
%     conditions.

stoch_simul(hp_filter = 1600, order = 1, irf = 50, periods = 500);