%% Excercise 6.1
clc;clear all;close all;
%% Point a
n = 50;
A = 4*eye(n) - diag(ones(n-1, 1), 1) - diag(ones(n-1, 1), -1) - diag(ones(n-2, 1), 2) - diag(ones(n-2, 1), -2);
b = 0.2*ones(n, 1);
I = eye(n);
T = 2*eye(n) - diag(ones(n-1, 1), 1) - diag(ones(n-1, 1), -1);

% Both matrices are clearly symmetric
eig_A = eig(A);
eig_T = eig(T);

if all(eig_A>0) && all(eig_T>0)
% The fact that all eigenvalues are positive reveals that they are also positive definite.
    fprintf("Positive definite Matrices\n");
end
  
%% Point b
% Apply the Richardson method starting from x = 0, with a tolerance equal to
% 10−6 and P = I. Compare the required number of iterations (if the method is
% convergent) for alpha = 0.2, alpha = 0.33 and alpha = alpha_opt.

x0 = zeros(n, 1); tol = 1e-6; maxit = 10000; 
% b.1
alpha = 0.2;
rho_1=max(abs(eig(I - alpha*A))); % less than 1--> convergence OK
% or since the Matrix A is s.d.p.
% alpha_max= 2/max(eig(P\A)); %alpha<alpha_max---> convergent
[x1, iter1, incr1] = richprec(A, b, I, alpha, x0, tol, maxit);

%b.2
alpha = 0.33;
rho_2=max(abs(eig(I - alpha*A))) % greater than 1 --> NOT convergent
% You can check that this alpha is s.t. alpha>2/max(eig_A)
%[x2, iter2, incr2] = prec_rich_method(A, b, I, alpha, x0, tol, maxit) % we already know that it will not converge

alpha = 2/(min(eig_A) + max(eig_A));
rho_3=max(abs(eig(I - alpha*A))) % less than 1-->optimal convergence
[x3, iter3, incr3] = richprec(A, b, I, alpha, x0, tol, maxit)

% Among the proposed values, the minimum number of iterations is obtained
% at alpha = alpha_opt

%% Apply the Richardson method starting from x = 0, with a tolerance equal to
%  10−6 , P = T, α = αopt . Compare the required number of iterations with the one
%  associated with the non-preconditioned case. Compare the condition numbers of A
%  and P\A.
x0 = zeros(n, 1); tol = 1e-6; maxit = 10000;

Tinv_A = T\A;
eig_Tinv_A = eig(Tinv_A);
alpha = 2/(min(eig_Tinv_A) + max(eig_Tinv_A));
rho_4=max(abs(eig(I - alpha*Tinv_A))) % less than 1
[x4, iter4, incr4] = richprec(A, b, T, alpha, x0, tol, maxit)

cond_A = cond(A)
cond_Tinv_A = cond(Tinv_A)

% Preconditioning the linear system with T results both in a
% better performance of the method (less iterations are needed) 
% and a smaller condition number.

