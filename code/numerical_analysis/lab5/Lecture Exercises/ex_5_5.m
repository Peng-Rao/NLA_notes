%% Exam Sep 7,2023
clc; close all;clear

n=100;
A=-19*diag(ones(n-2,1),-2) - 7/3*diag(ones(n,1)) +...
+3*diag(ones(n-1,1),1) + 3*diag(ones(n-1,1),-1)+...
+57/3*diag(ones(n-2,1),-2);
% Let's look at the matrix
figure()
spy(A)
xex=ones(n,1);
a=A*xex;
% It's tridiagonal: cheapest method is the thomas alghoritm
[L,U,xa] = thomas(A,a);
xa

C=-7*diag(ones(n,1))+ 2*diag(ones(n-2,1),-2) +2*diag(ones(n-2,1),2);
B=C'*C;
% Let's look at the matrix
figure()
spy(B)
b=B*xex;

% The matrix is penta-diagonal and simmetric and positive definite
%%
any(eig(B)<=0)
% we can use the cholesky factorization

H=chol(B);
y = H'\b;
xb = H\y

%%
err1=norm(xa-xex,inf)/norm(xex, inf)
err2=norm(xb-xex,inf)/norm(xex, inf)
