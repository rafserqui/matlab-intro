function EE = ldot(t,L,theta,B,beta,X,cbar)
    EE = L.*theta.*(B.*(X./L).^(beta) - cbar);
end