%% Homework 5.4
clc
clear all
close all

A = [1 2 -2;
     1 1  1;
     2 2  1];
b = A * [1 2 3]';
%% Apply Jacobi method to compute the solution with a tolerance of 10−5 and 10−8
D  = diag(diag(A));
L  = tril(A, -1);
U  = triu(A, 1);
Bj = -D \ (L+U);
gj = D \ b;

x0 = zeros(3,1);

iter   = 0;
%tol    = 1e-5;
tol    = 1e-8;
maxit = 100;

[xj, iterj, incrj] = stationary_method(Bj, gj, x0, tol, maxit)

% Four iterations are performed in both cases, independently on the tolerance values we considered.
% Notice that the last increment is actually zero!

% The spectral radius is very small.

eig(Bj)
rhoBj  = max( abs( eig(Bj) ) )

% Indeed, computing by hand the eigenvalues we see that
% lambda_1 = lambda_2 = lambda_3 = 0, so the spectral radius is actually 0.

% Compute the cube of Bj
Bj^2
Bj^3        % At the third step we get the null matrix.

% Thus, for all k > 3
% Jacobi method has converged to the exact solution

