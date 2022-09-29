function [xstar] = solution_sencond_degree(p)
    % Function that computes the solution to a second degree equation
    % It implements x = (-b +- sqrt(b^2 - 4ac))/2a
    a = p(1);
    b = p(2);
    c = p(3);

    % Check if a = 0 => bx + c = 0 => x = -c/b
    if a == 0
        xstar = -c/b;
    else
        xstar(1) = (-b + sqrt(b^2 - 4*a*c))./(2*a);
        xstar(2) = (-b - sqrt(b^2 - 4*a*c))./(2*a);
    end
end