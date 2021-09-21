function  pass = grades_loop(grades,nstudents)
%----------------------------------------------
% Rafael Serrano Quintero
% September 2021
%----------------------------------------------
    pass = ones(nstudents,1);
    
    for student = 1:nstudents
        if grades(student,1) >= 5
            pass(student,1) = 1;
        else
            pass(student,1) = 0;
        end
    end
end