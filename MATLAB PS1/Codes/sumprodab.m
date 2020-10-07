%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

This function takes as inputs two scalars and displays the message 

"The sum of ___ and ___ is equal to ___"
"The product of ___ and ___ is equal to ___"
%}

function [mysum,myprod] = sumprodab(a,b)
    % Two separate outputs
     mysum = ['The sum of ',num2str(a),' and ',num2str(b),' is equal to ', num2str(a+b)];
     myprod = ['The product of ',num2str(a),' and ',num2str(b),' is equal to ', num2str(a*b)];
%     
%     % A single output in two lines
%      together = sprintf('The sum of %.f and %.f is equal to %.f \n The The sum of %.f and %.f is equal to %.f',a,b,a+b,a,b,a*b);
%      disp(together)
end