function y = my_factorial(n)
%----------------------------------------------
% Rafael Serrano Quintero
% September 2021
%----------------------------------------------
% This function illustrates two ways of computing
% the factorial in Matlab without the factorial()
% function. Note that these two ways of computing
% the factorial ARE NOT RECOMMENDED TO USE, they 
% are just for illustration purposes. The built-in
% function is optimized and constructed to avoid
% errors.

    y = prod(1:n);
    
    
%{
Not recommended way:
    
    ff = 1;
    for tt = 1:n
        ff = ff*tt;
    end
    y = ff;
%}
end
