%% Excercise 5.4
clc
clear all
close all

% Matrix definition.
n =10;
A =3* eye ( n ) -2* diag ( ones (n -1 ,1) ,1) - diag ( ones (n -1 ,1) , -1);

% Calculation of the b vector
b = A * ones (n ,1);

% Iteration matrices.
D = diag( diag(A) );
E = -tril(A, -1);

% Bj= inv(D)*(D-A); the following implementation is faster as declared by
% Matlab
Bj = D \ (D-A)
% Bgs =  inv(D-E)*(D-E-A); the following implementation is faster as declared by
% Matlab
Bgs =  (D-E) \ (D-E-A)

% The matrices do not have particular properties like being strictly diagonally dominant or symmetric and positive definite.
norm(Bj)
norm(Bgs)

% Moreover, the 1,2 and infinity norms of Bj and Bgs for all matrices A are
% ALL bigger than 1. So we cannot use this argument to conclude convergence
% for any case.
% Hence we have to compute the spectral radii of both matrices to determine
% whether the methods are convergent or not.

rhoBj = max( abs( eig(Bj) ) )
rhoBgs = max( abs( eig(Bgs) ) )

% Iteration vector
gj  = D \ b;
ggs = (D-E) \ b;

x0 = zeros(10,1);
tol = 1e-12;
maxit = 500;

% Jacobi method
[xj, iterj, incrj] = stationary_method(Bj, gj, x0, tol, maxit)

% Gauss-Seidel method
[xgs, itergs, incrgs] = stationary_method(Bgs, ggs, x0, tol, maxit)
