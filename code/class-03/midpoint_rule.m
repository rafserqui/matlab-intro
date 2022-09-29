function [value] = midpoint_rule(a,b,n,myfunc)
    % Numerical integration with midpoint rule
    xpts = zeros(n,1);
    h = (b-a)/n;
    for jj=1:n 
        xpts(jj,1) = a + (jj - 1/2)*h;
    end
    value = h*sum(myfunc(xpts));
end