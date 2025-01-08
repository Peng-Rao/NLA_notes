clear; clc; close all;

%% Use MATLAB to determine if the methods obtained by setting alpha = 1, -1/2 and -1 
% are convergent to the exact solution
format short e 
A = eye(10) + triu(pascal(10), 1);
b = (1:10)';

display(cond(A));

B1 = eye(10) + 1 * A;
rho1 = max(abs(eig(B1))); % rho = 1 don't converge

B2 = eye(10) - 1 / 2 * A;
rho2 = max(abs(eig(B2))); % rho = 0.5 converge


B3 = eye(10) - 1 * A;
rho3 = max(abs(eig(B3))); % rho = 0 converge

%% Implement the method for the cases in which convergence is assured.
if isequal(A, A') && all(eig(A)>0)
    fprintf("A is symmetric positive definite.\n")
end
ei = eig(A);
P = eye(size(A));
alpha = 2 / (max(abs(eig(A))) + min(abs(eig(A))));
iter_max = 5000;
tol = 1e-6;
x0 = zeros(10, 1);
[x, iter, incr] = richprec(A, b, P, alpha, x0, iter_max, tol);