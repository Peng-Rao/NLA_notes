%% Excercise 1.5
% Pay attention, you cannot use "eps" since it is a built-in variable
k = 0;
EPS = 1/2;
while (1 + EPS) > 1
  EPS_old = EPS;    % keep track of the value
  EPS = EPS / 2;
  k = k + 1;
end
EPS_old		% computed with the ad-hoc procedure
k			% Number of iterations, which is also the numer of digits in the mantissa, according to the standard
eps			% MATLAB built-in
