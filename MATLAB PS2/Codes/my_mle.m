%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018
%}
function [ff] = my_mle(rho,X,y)
    [T,vars] = size(X);
    yhat = X*rho(1:vars);
    sig = rho(end);
    likelihood = exp(-(y-yhat).^2/(2*sig))./sqrt(2*pi*sig);
    ll = log(likelihood);
    
    ff = -sum(ll);  % Note the - sign, we want to MAXIMIZE!
end