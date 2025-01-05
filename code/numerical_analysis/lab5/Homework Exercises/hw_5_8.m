%% Homework 5.7
clc
clear all
close all

A = diag(3*ones(6,1)) - diag(ones(5,1), 1) - diag(ones(5,1), -1);
A(1, 6) = -1;
A(2, 5) = -1;
A(5, 2) = -1;
A(6, 1) = -1;
A

b = [1 0 1 1 0 1]';

% The matrix is clearly symmetric, and the computation of the eigenvalues
% shows that is positive definite, so the Gauss-Seidel method converges.
% We cannot conclude anything on the convergence of the Jacobi method because
% the matrix is only weakly diagonally dominant.

D = diag(diag(A));
L  = tril(A, -1);
U  = triu(A, 1);

Bj = -D \ (L+U);
rhoBj = max(abs(eig(Bj)))

Bgs = -(D + L) \ U;
rhoBgs = max(abs(eig(Bgs)))

% Both Jacobi and Gauss-Seidel method will converge.

x0 = zeros(6,1);
tol = 1e-8;

% Jacobi
normBj = norm(Bj, 2)
% Choose 2-norm becuase the implementation of stationary_method provides
% stopping criterion in 2-norm. This is actually the spectral radius itself,
% since matrix A is symmetric.
gj = D \ b;
x1j = Bj*x0 + gj;
kjmin_2 = log(tol*(1 - normBj)/norm(x1j-x0)) / log(normBj)

% Rounding up to the first integer the estimate says that tolerance
% will be satisfied in no more than 91 iterations.

% Gauss-Seidel
normBgs = norm(Bgs)
ggs = (D + L) \ b;
x1gs = Bgs*x0 + ggs;
kgsmin_2 = log(tol*(1 - normBgs)/norm(x1gs-x0)) / log(normBgs)

% The estimate says that tolerance will be satisfied in no more than 89 iterations

[xj,niterj] = stationary_method(Bj, gj, x0, tol, 1000)
[xgs,nitergs] = stationary_method(Bgs, ggs, x0, tol, 1000)

% We get convergence in respectively 83 and 45 iteration, in accordance
% with what we found from the estimates.
