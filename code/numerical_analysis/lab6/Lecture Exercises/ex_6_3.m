%% Excercise 6.2
clear; close all;clc;
%% Build the matrix
n = 20;
A = ones(n);
for i = 1:n
    A(i,1:i) = 2^i;
end
b = (1:n)';
x_ex = A\b;
%% Solve the system with tree different preconditioners
% convergence iff 0 < alfa < 2min(Re(eig)/abs(eig)^2)
%% P=I
P=eye(n); x0=ones(n, 1); toll=1e-6; nmax=1e3; 
eigs=eig(P\A);
alpha_max=2*min(real(eigs)./abs(eigs).^2);
alpha1=alpha_max/2;
[x1, it1, res1] = richprec(A,b,P, alpha1, x0,nmax, toll);
fprintf("Iterations: %d\t", it1)
fprintf("Normalized Residual: %d\t", res1(end))
fprintf("Condition Number: %d\n", cond(P\A))

%% P=D
P=diag(diag(A));
eigs=eig(P\A);
alpha_max=2*min(real(eigs)./abs(eigs).^2);
alpha2=alpha_max/2;
[x2, it2, res2] = richprec(A,b,P, alpha2, x0,nmax, toll);
fprintf("Iterations: %d\t", it2)
fprintf("Normalized Residual: %d\t", res2(end))
fprintf("Condition Number: %d\n", cond(P\A))

%% P=D-E
P=tril(A);
eigs=eig(P\A);
alpha_max=2*min(real(eigs)./abs(eigs).^2);
alpha3=alpha_max/2;
[x3, it3, res3] = richprec(A,b,P, alpha3, x0,nmax, toll);
fprintf("Iterations: %d\t", it3)
fprintf("Normalized Residual: %d\t", res3(end))
fprintf("Condition Number: %d\n", cond(P\A))