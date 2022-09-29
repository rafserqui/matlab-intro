clear
clc

N = 10000;
A = randn(N, N);

[R, C] = size(A);

% Slowest way
tic
for rr = 1:R
    for cc = 1:C
        A(rr,cc) = A(rr, cc) * 2;
    end
end
slowest = toc;

% Slow way
tic
for cc = 1:C
    for rr = 1:R
        A(rr,cc) = A(rr, cc) * 2;
    end
end
slow = toc;

% Fast vectorized way
tic
A = 2.*A;
fast = toc;
disp({'Slowest', 'Slow', 'Fast'})
disp({slowest, slow, fast})