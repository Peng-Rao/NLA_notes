%% Excercise 5.3
clc
clear all
close all

% Matrix definition. Uncomment the one you want to analyze
A = [1 2 2; 1 1 1; 2 2 1];        % None of the methods converge
%A = [2 1 -2; 1 2 1; 2 1 2];       % Both methods converge
%A = [1 2 -2; 1 1 1; 2 2 1];       % Just Jacobi method converges
%A = [1 1 -2; 1 2 1; 2 1 2];       % Just Gauss-Seidel method converges

x = [1 2 3]';       % Exact solution
b = A*x;            % Right hand side

% Iteration matrices.
D = diag( diag(A) );
E = -tril(A, -1);
% L = tril(A, -1);
% U = triu(A, 1);

% Bj  = -D \ (L+U)       % Jacobi method
% Bgs = -(D+L) \ U       % Gauss-Seidel method

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

x0 = [0 0 0]';
tol = 1e-6;
maxit = 100;

% Jacobi method
[xj, iterj, incrj] = stationary_method(Bj, gj, x0, tol, maxit);
xj
iterj
% Gauss-Seidel method
[xgs, itergs, incrgs] = stationary_method(Bgs, ggs, x0, tol, maxit);
xgs
itergs
%{
 Convergence of Jacobi and Gauss-Seidel method are not related to each other.
 As we could see they can both diverge or be convergent or also just one can
 converge.
 It always depends on the matrix. They both have some advantages. Since in Jacobi
 method each component of the approximation of the solution is obtained
 using information at the previous iteration, the algorithm is highly
 parallelizable. This is not possible for Gauss-Seidel method, since each
 component is obtained using the information on the other components
 already computed at the current iteration. However this smarter use of
 the information, can speed up convergence.
%}
