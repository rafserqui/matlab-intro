%{
Rafael Serrano Quintero
April 2021

This function illustrates a (conceptually) slightly more complex way of
computing the factorial using **recurrence**.
%}
function F = my_fac(n)
    if n == 0
        F = 1;
    else
        F = n*my_fac(n-1);
    end
end