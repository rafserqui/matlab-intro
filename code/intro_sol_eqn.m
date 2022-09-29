close all
clear
clc

% Define function
gq = @(q) (3/2) .* q.^(1/2) + (6/5) .* q.^(1/5) - 1;
ql = linspace(0, 1);

% Find zero
qopt = fzero(gq, 0.5);

figure
plot(ql, gq(ql))
hold on
plot(ql, zeros(size(ql)), '--k')
plot(qopt, gq(qopt), 'o', 'Color', 'red', 'MarkerFaceColor', 'red')
