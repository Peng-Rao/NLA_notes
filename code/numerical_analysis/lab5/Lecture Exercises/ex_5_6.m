%% 2a
% The MATLAB commands are:
n = 7;
a = 32;
B = eye (n) - diag (10+[1:n-1], -1) - diag (10+[1:n-1], +1);
% The result is:
A = B + a * eye (n)


%% 2b
% LU factorization of A
[L, U, P] = lu (A);
% Patterns of A, L, U, and P
figure (1)
spy (A)
figure (2)
spy (L, 'x')
hold on
spy (U, 'o')
figure (3)
spy (P)
% Number of nonzeros in A, L, and U
nnz(A);
nnz(L);
nnz(U);

% Fromt the sparsity pattern and from the number of nonzeros in L, U, A, and P, it is clear that:
% -The pivoting was not performed, indeed, the sparsity pattern of P is the identity matrix.
% - The fill-in does not occur, indeed, the sparity pattern of L and U is the same of A.
% - The number of nonzeros in L and U is the same of A plus 7 : nnz(L)+nnz(U) = nnz(A)+7.
%   This is because the seven diagonal elements are counted twice, once in L and once in U, because they are shared by the two matrices.

%% 2c
n = 7;
a = 1;
B = eye (n) - diag (10+[1:n-1], -1) - diag (10+[1:n-1], +1);
A = B + a * eye (n);
xex = ones(n, 1);
b   = A * xex;
[y, k] = jacobi (A, b, b*0, 1e-6, 100)
norm (y - xex, 2)
% The method does not converge because the spectral radius of the iteration matrix is greater than 1.
Bj=eye(n)-diag(diag(A))\A;
rhobj=max(abs(eig(Bj)))

%2d
n = 7;
a = 32;
B = eye (n) - diag (10+[1:n-1], -1) - diag (10+[1:n-1], +1);
A = B + a * eye (n);
xex = ones(n, 1);
b   = A * xex;
[y, k] = jacobi (A, b, b*0, 1e-6, 100)
norm (y - xex, 2)
Bj=eye(n)-diag(diag(A))\A;
rhobj=max(abs(eig(Bj)))
% The method performed 54 iterations.
% The error in the 2-norm of the solution, in this case, is of order 10^-6.
% This is consistent with the theoretical result, which guarantees the convergence of the Jacobi method for strictly diagonally dominant matrices by rows.
