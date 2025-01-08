%% define the function
f = @(x) sqrt(1 - x .^ 2);
a = -1;
b = 1;

%% using the composite trapezoidal and Simpson rules
for k = 1:9
  n(k) = 3^k;
  m_t(k) = n(k) - 1;
  m_s(k) = (n(k) - 1) / 2;
  int_t(k) = composite_trapezoidal(f, a, b, m_t(k));
  int_s(k) = composite_simpson(f, a, b, m_s(k));
end

%% Estimate the order of accuracy of the two methods and comment on the results.
err_t = abs(pi/2 - int_t);
err_s = abs(pi/2 - int_s);

p_t = -diff(log(err_t)) / log(3);
p_s = -diff(log(err_s)) / log(3);

% Comment
% The rate of convergence of the two methods is 1.5:
% the reduction of the order of accuracy is due to the fact that the
% integrand function is not sufficiently smooth to apply the previous
% convergence results
% (C^2 regularity for the trapezoidal rule, C^4 regularity for the Simpson rule,
% but the function is only C^0).