clc;clear;close;

%% Point a

A=[2 -1 0; -1 3 1; 0 -1 4];
xex = [1/2 1/3 1/4]';
b=A*xex;
x0=[0 0 0]';
nmax=100;
tol=1e-2;
[x2,k2]=jacobi(A,b,x0,tol,nmax)
tol=1e-3;
[x3,k3]=jacobi(A,b,x0,tol,nmax)
tol=1e-4;
[x4,k4]=jacobi(A,b,x0,tol,nmax)

%% Point b
% As expected, the number of iterations required to achieve convergence increases as the tolerance decreases.
% Additionally, as the tolerance decreases, the accuracy of the numerical solution improves, as can be seen from 
% the comparison with the exact solution [0.5, 0.3333, 0.25]

%% Point c
tol=1e-4;
[xgs,kgs]=gs(A,b,x0,tol,nmax)

%% Point d
%The matrix A is strictly diagonally dominant by rows, 
% as evidenced by the following: 
% for the first row, |2| > |−1|; 
% for the second row, |3| > |−1| + |1|; 
% for the third row, |4| > |−1|.
% Furthermore, since matrix A is tridiagonal, 
% we know from theory that either both methods converge or neither does.
% In cases where they do converge, the Gauss-Seidel method is faster than the Jacobi method. 
% This is confirmed by the results obtained (5 iterations for Gauss-Seidel versus 8 for Jacobi).

%% Point e

n=3;
D = diag(diag(A));
Bj = eye(n) - D\A;
lmaxj=max(abs(eig(Bj)))
E=-tril(A,-1);
F=-triu(A,1);
Bgs=(D-E)\F;
lmaxgs=max(abs(eig(Bgs)))
%These results show that the spectral radius associated with the Jacobi 
% method is greater than that of the Gauss-Seidel method, 
% as expected from theory and confirmed by the numerical results obtained in point 1d).
% More Precisely  rhoGS=rhoJ^2.