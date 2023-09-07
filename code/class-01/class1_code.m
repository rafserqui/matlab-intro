%{
=========================================================
            === INTRODUCTION TO MATLAB ===
=========================================================
Rafael Serrano Quintero
April 2021

This code shows the first commands and introduction to follow during the
class.
%}

clear
clc

%==========================================================
                % === Creating Variables === %
%==========================================================

% Assignment and basic operations
x = 5;
disp(x*2)
disp(x-7)
disp(x+7)

% Creating variable from another
y = x^2;
disp(y)

% Assignment vs Equality
x = 3;
y = 4;
x = y;
y = 2;

disp(x)

% === Ex. 1: Solve Complex Operations === %
x = [0;pi/4]; 

op1 = (log(1 + x.^2) - sqrt(1 + x.^2)) / (1 + sin(x).^2);
op2 = log(abs(x - pi)) + x.*exp(x);

%=========================================================
                        % === Vectors === %
%=========================================================

rowV = [1 2 3 4 5];
rowV2 = [6,7,8,9,10];
colV = [1;2;3;4;5];

% Other useful ways of creating a vector
% A sequence from 0 to 10 in steps of 2
seq1 = 0:2:10;
% 1000 equally spaced elements in [0,10]
seq2 = linspace(0,10,1000);

%==========================================================================
                            % === Matrices === %
%==========================================================================

A = [1 2 3; 4 5 6; 7 8 9];
B = [4 5 6; 7 9 2; 1 5 32];
ConcatenatedMatrix = [rowV;rowV2];

disp(A(2,3))    % Element in row 2 and column 3 of matrix A
disp(colV(1))  % First element in colV vector

% Matrix multiplication
disp(A*B)

% To transpose a matrix use transpose() or '
disp(A')
disp(transpose(A))

% Element-wise multiplication of A and B
disp(A.*B)

% Be careful with element wise multiplication. Check what would happen if:
disp(rowV.*rowV2')

% === Ex. Concatenate Matrices === %
v1 = [1 2 3];
v2 = [4; 5; 6];
M1 = [v1', v2];
M2 = [v1; v2'];

% === Ex. Solve the system === %
b = [1; - 2; 0];
A = [3 2 -1; 2 -2 4; -1 0.5 -1];
x = inv(A)*b;   % Slower and inaccurate
x_oth = A\b;    % This method is preferred
x_oth2 = mldivide(A,b); % Same as the previous one
disp([x,x_oth,x_oth2])
%{
Backslash solves even when A is singular

A = magic(4);
b = 34.*ones(4,1);
x = A\b

Note that x and x_oth are not **exactly** equal, to check that

x == x_oth
%}

%==========================================================================
                % === Relational and Logical Operators === %
%==========================================================================
A = [3, 2, -1, 20, 5, 6, -2, 5.6];
disp(A > 5)
disp(A == 5)
disp(A < 5)

disp(A > 5 | A < 9)
disp(~(A > 3 & A < 6))

% If-Else Statements
b = 3;
if b < 0
    disp('b is negative')
else
    disp('b is non-negative')
end

% For loops
T = 100;
rho = 0.85;
y = zeros(100,1);
for t=2:T
    y(t,1) = rho*y(t-1,1) + randn;
end

a = 0;
while a < 25
    a = a + 1;
end

%==========================================================================
                    % === Loops and Conditionals === %
%==========================================================================
% === Ex. List of students === %
nstudents = 200;
grades = 10.*rand(nstudents,1);
pass = ones(nstudents,1);

for student = 1:nstudents
    if grades(student,1) >= 5
        pass(student,1) = 1;
    else
        pass(student,1) = 0;
    end
end

pass_vect = zeros(nstudents,1);
pass_vect(grades >= 5) = 1;

% To test they are equal
isequal(pass,pass_vect)

%==========================================================================
                            % === Figures === %
%==========================================================================
figure
plot(1:T,y)

%{
Plot sin(x) and cos(x) in [0,3pi]
%}

x = linspace(0,3*pi,10000);
y = sin(x);
g = cos(x);

figure
plot(x,y,'--','LineWidth',1.35)
hold on
grid on
plot(x,g,'-','LineWidth',1.35)
xlim([0 3*pi])
legend({'$\sin(x)$','$\cos(x)$'},'Interpreter','latex','Location','best')
title('Sine versus Cosine')
xlabel('$$x$$','Interpreter','latex')
ylabel('$$F(x)$$','Interpreter','latex')

% === Ex.Sinusoidal Wave === %
x = linspace(0,10,10000);
F = sin(x);
A = 4;              % Amplitude
k = pi/2;           % Frequency
G = A.*sin(k.*x);

figure
plot(x,F,'-','LineWidth',1.2)
hold on
grid on
plot(x,G,'--','LineWidth',1.2)
legend({'$\sin(x)$','$A\sin(\omega \times x)$'},'Interpreter','latex','Location','best')
title('Sinusoidal Waves')
xlabel('$$x$$','Interpreter','latex')

%==========================================================================
                            % === Functions === %
%==========================================================================

% === Ex. Function for Sinusoidal Wave === %
A = 4;
freq = 1/2;
lb = 0;
ub = 6;
my_wave(A,freq,lb,ub)

tic
my_factorial(5) % User-defined
toc

tic 
factorial(5)    % Matlab's function
toc


% === Anonymous Functions === %
bytwo = @(x) 2*x;
a = bytwo(10);

% Rosenbrock Example
rosen2d = @(x,y) (1 - x).^2 + 100.*(y - x.^2).^2;

xvals = [1; 0; 1; 0];
yvals = [1; 0; 0; 1];

rosen2d(xvals, yvals)


