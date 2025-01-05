clc; clear;
A = [1 1e10 1 1; 1e10 1 1 1e10; 1 1 1e-10 1; 1 1e10 1 1e10];
b = [1e10 + 3 2 * 1e10 + 2 3 + 1e-10 2e10 + 2]';
x_ex = ones(4, 1);

% solution with LU decomposition without pivoting
[L1, U1] = lu_decomposition(A);
y1 = L1 \ b;
x1 = U1 \ y1;

[L2, U2, P2] = lu(A);
y2 = L2 \ (P2*b);
x2 = U2 \ y2;

%% Compute the infinity norm of the error associated with the solution of the previous item
% infinity norm of the error
err1=norm(x_ex - x1, inf);
err2=norm(x_ex - x2, inf);
% As already noted, the best solution is that obtained with the pivoting.

%% Can we apply the Cholesky decomposition to matrix A?
% Cholesky decomposition? -> no, because A is symmetric but not definite
% positive definite, since the eigenvalues are not all positive.
eigenvalues=eig(A)

% normalized residual
res1=norm(b - A*x1, inf) / norm(b, inf)
res2=norm(b - A*x2, inf) / norm(b, inf)

% In both cases the normalized residuals are very small.
% Nevertheless the relative error is not small in both cases.
% The normalized residual is a good estimate of the relative error
% only when the condition number of the matrix is small!
% Furthermore if the condition number is large the pivoting is necessary to avoid the amplification of round-off errors. 

K=cond(A, inf)