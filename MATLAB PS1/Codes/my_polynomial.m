%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

A function that evaluates polynomials given the coefficients and the
coefficients of the derivative. It takes coefficients as:

p1 x^n + p2 x^n-1 + p3 x^n-2+...+pn+1

So, a second degree polynomial needs a vector of length 3

Note that in this function, the first coefficient is the one assigned to
the highest order term. It could be easily transformed so that the first
coefficient is the constant term.
%}
function [poly_eval,derivative] = my_polynomial(coef,x)
    N = length(coef);
    %Pre-allocate for speed
    poly_elem = zeros(N,1);
    derivative = zeros(N,1);
    
    for ii = 1:N
       poly_elem(ii,1) = coef(ii).*x^(N-ii);
       derivative(ii,1) = (N-ii).*coef(ii);
    end
    derivative = derivative(1:N-1,:); % Remove constant
    poly_eval = sum(poly_elem);
end