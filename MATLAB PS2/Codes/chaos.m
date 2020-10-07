%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

This function takes as inputs an initial condition, a parameter $rho$, and
a scalar T denoting the number of periods and simulates a function:

x_{t+1} = rho*x_{t}*(1-x_{t})

It also displays errors in case x0 > 1 or x0 < 0 and in case rho > 4 or rho
< 0.
%}

function[sequence_x] = chaos(x0,rho,T)
    if x0>1 || x0<0
        sequence_x = ['Variable is not in the range considered'];
    elseif rho>4 || rho<0
        sequence_x = ['Parameter rho is not in the range considered'];
    else
        sequence_x = x0.*ones(T,1);
        for t=2:T
            sequence_x(t,1) = rho.*sequence_x(t-1,1).*(1-sequence_x(t-1,1));
        end
    end
end
