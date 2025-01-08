clear; clc; close all;

%% define matrix
B = rand(5) + diag(10 * ones(5, 1));
A = B * B';
b = ones(5, 1);

%% Compute the solution of the system using the non preconditioned gradient
x_0 = zeros(5, 1);
P = eye(size(A));
max_it = 1000;
tol = 1e-3;

[x, iter, residual, x_k] = gradprec(A, b, P, x_0, max_it, tol);

% A \ b
