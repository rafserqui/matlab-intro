%{
===========================================================================
                    === QED MACROECONOMICS III ===
===========================================================================
Rafael Serrano Quintero
April 2018

This code shows the first commands and introduction to follow during the
class.
%}

clear
clc

%==========================================================================
                        % === Creating Variables === %
%==========================================================================
x = 5;
y = x.^2;
disp(y)

% === Ex. 1: Solve Complex Operations === %
x = [0;pi/4]; 

op1 = ((log(1+x.^2)).^2-sqrt(1+x.^(2/3)))./(1+sin(x).^2);
op2 = log(abs((x-pi)./(x+pi)))+sqrt(exp(x)./(1+x.*exp(x)));

%==========================================================================
                            % === Vectors === %
%==========================================================================

rowV = [1 2 3 4 5];
rowV2 = [6,7,8,9,10];
colV = [1;2;3;4;5];

% Other useful ways of creating a vector
seq1 = 0:10; % A sequence from 0 to 10
seq2 = linspace(0,10,1000); % A sequence from 0 to 10 formed by 1000 equally spaced elements

%==========================================================================
                            % === Matrices === %
%==========================================================================

A = [1 2 3; 4 5 6; 7 8 9];
B = [4 5 6; 7 9 2; 1 5 32];
ConcatenatedMatrix = [rowV;rowV2];

% To transpose a matrix use transpose() or '

% Element-wise multiplication of A and B
A.*B

% Be careful with element wise multiplication. Check what would happen if:
rowV.*rowV2'

% Matrix multiplication
A*B

% === Ex.2 Solve the system === %
b = [1;-2;0];
A = [3 2 -1;2 -2 4; -1 0.5 -1];
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
                            % === Figures === %
%==========================================================================

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

% === Ex. 3 Sinusoidal Wave === %
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

% === Ex. 4 Function for Sinusoidal Wave === %
A = 4;
freq = pi/2;
lb = 0;
ub = 10;
my_wave(A,freq,lb,ub)

%==========================================================================
                    % === Loops and Conditionals === %
%==========================================================================
tic
my_factorial(5) % User-defined
toc

tic 
factorial(5)    % Matlab's function
toc
% === Ex. 5 List of students === %
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