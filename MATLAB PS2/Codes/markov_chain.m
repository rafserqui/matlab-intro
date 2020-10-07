%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

This function generates a Markov Chain given an initial state, a stochastic
matrix P, the number of periods, and the number of states.
%}

function [mc_path] = markov_chain(P,x0,T,states)
    %For pre-allocation only
    mc_path = zeros(T,1);
    mc_path(1,1) = x0;
    for tt = 2:T
        psi = P(mc_path(tt-1),:);
        mc_path(tt,1) = randsample(states,1,true,psi);
    end
end