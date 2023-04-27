function [z1] = excess_demand_good1(p1,omega1A,omega1B,omega2A,omega2B,alpha,beta)
  z1 = alpha .* ((p1.*omega1A + omega2A) ./ p1) + beta .* ((p1.*omega1B + omega2B) ./ p1) - omega1A - omega1B;
end
