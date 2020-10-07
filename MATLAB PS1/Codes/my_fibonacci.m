%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

A function that evaluates the Fibonacci sequence for n integers. It takes
the first to elements, 0 and 1, and computes recursively each element of
the sequence.
%}

function y = my_fibonacci(n)
    fib = zeros(n,1);
    fib(2,1) = 1;
    
    for tt = 3:n
        fib(tt,1) = fib(tt-1,1)+fib(tt-2,1);
    end
    
    y = fib;
end