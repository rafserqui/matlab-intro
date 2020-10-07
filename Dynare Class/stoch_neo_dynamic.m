function [residual, g1, g2, g3] = stoch_neo_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(7, 1);
T14 = y(11)^(-params(5));
T20 = y(5)^(params(1)-1);
T32 = y(1)^params(1);
T33 = y(6)*T32;
T52 = y(1)^(params(1)-1);
T58 = y(5)^params(1);
lhs =y(7)^(-params(5));
rhs =params(2)*T14*(1+params(1)*y(10)*T20-params(3));
residual(1)= lhs-rhs;
lhs =y(5);
rhs =(1-params(3))*y(1)+T33-y(7);
residual(2)= lhs-rhs;
lhs =log(y(6));
rhs =params(4)*log(y(2))+x(it_, 1);
residual(3)= lhs-rhs;
lhs =y(3);
rhs =T33;
residual(4)= lhs-rhs;
lhs =y(4);
rhs =y(3)-y(7);
residual(5)= lhs-rhs;
lhs =y(9);
rhs =params(1)*y(6)*T52;
residual(6)= lhs-rhs;
lhs =y(8);
rhs =y(6)*(1-params(1))*T58;
residual(7)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(7, 12);

  %
  % Jacobian matrix
  %

T62 = y(6)*getPowerDeriv(y(1),params(1),1);
  g1(1,5)=(-(params(2)*T14*params(1)*y(10)*getPowerDeriv(y(5),params(1)-1,1)));
  g1(1,10)=(-(params(2)*T14*params(1)*T20));
  g1(1,7)=getPowerDeriv(y(7),(-params(5)),1);
  g1(1,11)=(-(params(2)*(1+params(1)*y(10)*T20-params(3))*getPowerDeriv(y(11),(-params(5)),1)));
  g1(2,1)=(-(1-params(3)+T62));
  g1(2,5)=1;
  g1(2,6)=(-T32);
  g1(2,7)=1;
  g1(3,2)=(-(params(4)*1/y(2)));
  g1(3,6)=1/y(6);
  g1(3,12)=(-1);
  g1(4,3)=1;
  g1(4,1)=(-T62);
  g1(4,6)=(-T32);
  g1(5,3)=(-1);
  g1(5,4)=1;
  g1(5,7)=1;
  g1(6,1)=(-(params(1)*y(6)*getPowerDeriv(y(1),params(1)-1,1)));
  g1(6,6)=(-(params(1)*T52));
  g1(6,9)=1;
  g1(7,5)=(-(y(6)*(1-params(1))*getPowerDeriv(y(5),params(1),1)));
  g1(7,6)=(-((1-params(1))*T58));
  g1(7,8)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],7,144);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],7,1728);
end
end
end
end
