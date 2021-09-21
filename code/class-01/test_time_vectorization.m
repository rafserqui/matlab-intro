%----------------------------------------------
% Rafael Serrano Quintero
% September 2021
%----------------------------------------------
close all
clear
clc

% === Ex. 5 List of students === %
nstudents = 1e3;
grades = 10.*rand(nstudents,1);

loop = @() grades_loop(grades,nstudents);
loop_time = timeit(loop);

vect = @() grades_vect(grades,nstudents);
vect_time = timeit(vect);

disp(vect_time / loop_time)