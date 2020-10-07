function [residual, g1, g2, g3] = stoch_neo_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 7, 1);

%
% Model equations
%

T11 = y(5)^(-params(5));
T18 = y(3)^(params(1)-1);
T19 = params(1)*y(4)*T18;
T28 = y(3)^params(1);
T29 = y(4)*T28;
lhs =T11;
rhs =params(2)*T11*(1+T19-params(3));
residual(1)= lhs-rhs;
lhs =y(3);
rhs =y(3)*(1-params(3))+T29-y(5);
residual(2)= lhs-rhs;
lhs =log(y(4));
rhs =log(y(4))*params(4)+x(1);
residual(3)= lhs-rhs;
lhs =y(1);
rhs =T29;
residual(4)= lhs-rhs;
lhs =y(2);
rhs =y(1)-y(5);
residual(5)= lhs-rhs;
lhs =y(7);
rhs =T19;
residual(6)= lhs-rhs;
lhs =y(6);
rhs =T28*y(4)*(1-params(1));
residual(7)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(7, 7);

  %
  % Jacobian matrix
  %

T52 = params(1)*y(4)*getPowerDeriv(y(3),params(1)-1,1);
T56 = getPowerDeriv(y(3),params(1),1);
T57 = y(4)*T56;
T75 = getPowerDeriv(y(5),(-params(5)),1);
  g1(1,3)=(-(params(2)*T11*T52));
  g1(1,4)=(-(params(2)*T11*params(1)*T18));
  g1(1,5)=T75-params(2)*(1+T19-params(3))*T75;
  g1(2,3)=1-(1-params(3)+T57);
  g1(2,4)=(-T28);
  g1(2,5)=1;
  g1(3,4)=1/y(4)-params(4)*1/y(4);
  g1(4,1)=1;
  g1(4,3)=(-T57);
  g1(4,4)=(-T28);
  g1(5,1)=(-1);
  g1(5,2)=1;
  g1(5,5)=1;
  g1(6,3)=(-T52);
  g1(6,4)=(-(params(1)*T18));
  g1(6,7)=1;
  g1(7,3)=(-(y(4)*(1-params(1))*T56));
  g1(7,4)=(-(T28*(1-params(1))));
  g1(7,6)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],7,49);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],7,343);
end
end
end
end
