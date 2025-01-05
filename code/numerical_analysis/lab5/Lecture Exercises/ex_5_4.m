%% Homework 5.5
clc
clear all
close all

n = 10;
A = 3*eye(n) - 2*diag(ones(n-1, 1), 1) - diag(ones(n-1, 1), -1);
b = A*ones(n, 1);

% Iteration matrices.
D = diag( diag(A) );
E = -tril(A, -1);
F = -triu(A, 1);

Bj  = eye(size(A)) -D\A;       % Jacobi method
Bgs = (D-E) \ F;       % Gauss-Seidel method

% Compute the spectral radii of both matrices to determine whether the
% methods are convergent or not.

rhoBj = max( abs( eig(Bj) ) )
rhoBgs = max( abs( eig(Bgs) ) )

% It can be noted that both spectral radii are less than 1, so that
% both method are convergent, and that the spectral radius of the Gauss-Seidel
% method is the square of the spectral radius of the Jacobi method.

% Iteration vector
gj  = D \ b;
ggs = (D-E) \ b;

x0 = zeros(n, 1);
tol = 1e-12;
maxit = 1000;

% Jacobi method
[xj, iterj, incrj] = stationary_method(Bj, gj, x0, tol, maxit)
% or you can use the jacobi function
%[xj, iterj]=jacobi(A,b,x0,tol, maxit);
% Gauss-Seidel method
[xgs, itergs, incrgs] = stationary_method(Bgs, ggs, x0, tol, maxit)
% or you can use the gs function
%[xgs, itergs]=gs(A,b,x0,tol, maxit);
% The number of iterations of the Gauss-Seidel method is approximately half
% of the ones of the Jacobi method.
