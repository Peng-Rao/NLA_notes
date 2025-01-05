%% Homework 5.6

clc; close all;clear
n=5;
B=rand(n)+ diag(10*ones(n,1));
A=B*B';
% Iteration matrices.
D = diag( diag(A) );
E=-tril(A,-1);
F=-triu(A,1);

Bgs=(D-E)\F;         %Jacobi method
Bj = eye(n) - D\A; %Gauss-Seidel method
      
% Compute the spectral radii of both matrices to determine whether the
% methods are convergent or not.

rhoBj = max( abs( eig(Bj) ) )
rhoBgs = max( abs( eig(Bgs) ) )

% It can be noted that both spectral radii are less than 1, so that
% both method are convergent.


%test
x=ones(n,1);
b=A*x;

% Iteration vector
gj  = D \ b;
ggs = (D-E) \ b;

x0 = zeros(n, 1);
tol = 1e-12;
maxit = 1000;

% Jacobi method
[xj, iterj, incrj] = stationary_method(Bj, gj, x0, tol, maxit)

% Gauss-Seidel method
[xgs, itergs, incrgs] = stationary_method(Bgs, ggs, x0, tol, maxit)



