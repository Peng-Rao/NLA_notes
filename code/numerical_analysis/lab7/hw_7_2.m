clear; clc; close all;

%% define the matrix
n = 10;
A = gallery('poisson', n);
b = A * ones(size(A(:,1)));

if isequal(A, A') && all(eig(A)>0)
    fprintf("A is symmetric positive definite.\n")
else
    return
end

%% The gradient method
x_0 = zeros(n * n, 1);
P = eye(size(A));
max_it = 1000;
tol = 1e-6;
[x, iter, residual, x_k] = gradprec(A, b, P, x_0, max_it, tol);

display(condest(A));
coverge_rate = (condest(A) - 1) / (condest(A) + 1);

