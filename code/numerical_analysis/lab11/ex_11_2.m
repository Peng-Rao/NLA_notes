%% Exercise 11.2
clc; close all; clear all;
% Implement the Backward Euler method in a suitable function, solving the nonliner 
% equation with newton method.
	

% Determine the step size $h$ such that the unitary local truncation error after the
% first step is smaller than $10^{-3}$. Solve the problem using such step.
% The LTE for Euler methods is
% tau(h) = h/2 * max(y''(t)) with t \in (tn, t(n+1))

f = @(t, y) - t*y.^2;

y_ex = @(t) 2 ./ (t.^2 + 2);
d2y_ex_dt = @(t) 4*(3*t.^2 -2) ./ (t.^2 + 2).^3;
fplot(d2y_ex_dt, [0, 2]);

% The plot shows that the maximum of y'' is attained at x = 0 and has absolute value 1.


tol = 1e-3;
h = 2*tol/1;
t0=0; T=2; 
[t, y_be] = backward_euler(f, 1, t0, T, h);
% The unitary truncation error after the first step is
1/h * abs(y_ex(h) - y_be(2));
% The request is satisfied.
figure
fplot(y_ex, [0, 2]);
hold on;
plot(t, y_be, 'r-');
legend('exact', 'BE')
