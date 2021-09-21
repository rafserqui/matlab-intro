function  pass_vect = grades_vect(grades,nstudents)
%----------------------------------------------
% Rafael Serrano Quintero
% September 2021
%----------------------------------------------
    pass_vect = zeros(nstudents,1);
    pass_vect(grades >= 5) = 1;
end