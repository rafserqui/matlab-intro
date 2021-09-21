function F = my_fac(n)
%----------------------------------------------
% Rafael Serrano Quintero
% September 2021
%----------------------------------------------
% This function illustrates a (conceptually) slightly more complex way of
% computing the factorial using **recurrence**.

    if n == 0
        F = 1;
    else
        F = n*my_fac(n-1);
    end
end