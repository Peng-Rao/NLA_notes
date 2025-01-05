%% Homework 5.9
clc; close all; clear

n=5;
alpha=1e-4;
A= eye(n);
A(1,n)= 1/alpha;

A


%% Write the iteration matrix J for the Jacobi method applied to the
 % solution of the linear system Ax = b and compute J^2 and J^3


D = diag(diag(A));
L  = tril(A, -1);
U  = triu(A, 1);

J = -D \ (L+U);
J2=J*J;
J3=J2*J;
%J2 is the null matrix. % Thus, for all k > 2
% Jacobi method has converged to the exact solution

%% Let x0=b=ones(n,1).  Will the Jacobi method
% converge? How many iterations will be required to ensure that the
% infinity norm of the error is less than 1e-9
rhoJ = max(abs(eig(J)))
% Jacobi method will converge because rhoJ<1

x0=ones(n,1);
b=x0;
tol=1e-9;
normJ= norm(J, 2)
% Choose 2-norm becuase the implementation of stationary_method provides
% stopping criterion in 2-norm. This is actually the spectral radius itself,
% since matrix A is symmetric.
gj = D \ b;
x1j = J*x0 + gj;
kjmin = log(tol*(1 - normJ)/norm(x1j-x0)) / log(normJ)


% The estimate says that tolerance will be satisfied in no more than 85 iterations

[xj,niterj] = stationary_method(J, gj, x0, tol, 1000)
% Jacobi converges in two itartions as expected


% Let B= A'A. Compute iteration matrix G for the Gauss-Seidel method. Will the Gauss-Seidel
% method converge?

B=A'*A;
G = -(D + L) \ U;
rhoBgs = max(abs(eig(G)))
% GS method will converge because rhoJ<1

% Gauss-Seidel
normG = norm(G)
ggs = (D + L) \ b;
x1gs = G*x0 + ggs;
kgsmin = log(tol*(1 - normG)/norm(x1gs-x0)) / log(normG)

% The estimate says that tolerance will be satisfied in no more than 89 iterations

[xgs,nitergs] = stationary_method(G, ggs, x0, tol, 1000)

