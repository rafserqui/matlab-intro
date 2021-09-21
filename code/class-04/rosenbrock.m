function [f, fgrad] = rosenbrock(x,a,b)
%----------------------------------------------
% Rafael Serrano Quintero
% September 2021
%----------------------------------------------
% An implementation of the Rosenbrock function
% with optional coefficients a and b. It also 
% provides the gradient if asked for it.
    % Not necessary, but for clarity we unpack the two inputs
    x1 = x(1);
    x2 = x(2);

    if nargin == 1
        a = 1;
        b = 100;
    end

    % Compute f
    f = b.*(x2 - x1.^2).^2 + (a - x1).^2;

    % Compute gradient (if necessary)
    if nargout > 1
        % Notice this is a vector, and the order MATTERS!
        fgrad = [-2.*a + 2.*x1 + 4.*b.*x1.^3 - 4.*b.*x1.*x2;
        2*b*(x2 - x1.^2)];
    end
end