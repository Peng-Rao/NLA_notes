% EXERCISE 2.4

a = -1;
b = 6;
f = @(x) atan(7 * (x - pi / 2)) + sin((x - pi / 2) .^ 3);
rootfinding_function_plot(f, a, b, true);

% The function is null at xi = {pi}/{2}.

xi_ex = pi / 2;
df = @(x) 7 ./ (1 + 49 * (x - pi / 2) .^ 2) + 3 * (x - pi / 2) .^ 2 .* cos((x - pi / 2) .^ 3);
df(xi_ex);
% The multiplicity of the root is one since the derivative of f at xi = {pi}/{2} is different from zero.

x0 = 1.5;
tol = 1e-10;
maxit = 1000;
[xi1, x_iter1] = newton(f, df, x0, tol, maxit);
xi1
iter1 = numel(x_iter1) - 1
err1 = abs(xi1 - xi_ex)
% Newton method converges to xi within the prescribed tolerance in very few iterations.

x0 = 4;
tol = 1e-10;
maxit = 1000;
[xi2, x_iter2] = newton(f, df, x0, tol, maxit);
xi2
iter2 = numel(x_iter2) - 1
err2 = abs(xi2 - xi_ex)
% Newton method does not converge to xi, and stops because of the maximum number of iterations has been reached.
%In this case the initial guess is not close enough to the root xi and the local convergence result does not apply.

tol = (b - a) / (2 ^ 30);
[xi3, x_iter3] = bisection(f, a, b, tol);
xi3
iter3 = numel(x_iter3)
err3 = abs(xi3 - xi_ex)
%%

% setting the bisection tolerance as (b-a)/2^k implies that the maximum
% number of iterations of bisection is set to k

tol_bisection = (b - a) / (5);
tol_newton = 1e-10;
maxit_newton = 1000;
[xi4, x_iter4_bisection, x_iter4_newton] = bisection_newton(f, df, a, b, tol_bisection, tol_newton, maxit_newton);
xi4
iter4_bisection = numel(x_iter4_bisection)
iter4_newton = numel(x_iter4_newton)
err4 = abs(xi4 - xi_ex)
