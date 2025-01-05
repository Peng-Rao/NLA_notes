%% Homework 5.8
clc
clear all
close all

A = [50 1 2;
      1 5 2;
      2 2 7];
b = [1 0 0]';

norm(A,1)
norm(A,inf)

% Yes, since A is symmetric and strictly diagonally dominant, it is
% positive definite. We can also check with the eigenvalues: all positive.
eig(A)

[L1, U1] = lu_decomposition(A)

% The condition number is quite small, so the matrix is well conditioned.
cond(A,2)

% All the methods we saw are suitable for the solution of the linear system,
% since the matrix is symmetric and positive definite.

D  = diag(diag(A));
L  = tril(A, -1);
U  = triu(A, 1);
Bj = -D \ (L+U);
rhoBj = max(eig(Bj))

% Asymptotic convergence rate
rate_jacobi = -log10(rhoBj)

% We now compute the estimate of the error after 4 iterations
x0 = zeros(3,1);
x1 = Bj*x0 + D\b;

esterr4 = norm(Bj)^4/(1-norm(Bj))*norm(x1-x0)

% We now compute the approximated solution after four steps.
xj = x0;
for i=1:4
    xj = Bj*xj + D\b;
end
x4 = xj
xtrue = A\b;

norm(xtrue-x4)
esterr4

% The error is lower than the estimate as we expected it to be.
