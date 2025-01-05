%% Excercise 6.5
clc;clear all ;close all
%% Point a
n = 20;
A = eye(n);
A(1, :) = A(1, :) + 1/n/10;
A(:, 1) = A(:, 1) + 1/n/10;

figure(1)
spy (A)


b(2:n,1) = (n*10 + 1)/(n*10);
b(1) = (11*n + 1)/(n*10);

xex = ones (n, 1);


%% compare exact and inexact factorization
[L, U] =  lu (A);
[Li, Ui] = ilu (sparse(A));

figure('Name', 'LU Factorization')
subplot(1,2,1)
spy (L)
title('L')
subplot(1,2,2)
spy (U)
title('U')

figure('Name', 'Incomplete LU Factorization')
subplot(1,2,1)
spy (Li)
title('incomplete L')
subplot(1,2,2)
spy (Ui)
title('incomplete U')

%% SOlve the system with P=I and P=LiUi;
eigs_p=eig(((Ui*Li)\A));
alpha_max=2/(max(eigs_p));
eigs=eig(A);
alpha_max=2/(max(eigs));
alpha  = 1.9;

x0 = zeros(size (b)); tol=1e-3; max_it=200;
%non preconditioned
[x1, iter1, incr1] = prec_rich_method(A, b, eye(n), alpha, x0, tol, max_it);
res1=(b-A*x1);
resnorm1 = norm (res1, 2);


% preconditioned with ILU
[x2, iter2, incr2] = prec_rich_method(A, b, Li*Ui, alpha, x0, tol, max_it);

res2=(b-A*x2);
resnorm2 = norm (res2, 2);


%% Again with the optimal value of alpha


alpha_opt_p=2/(max(eigs_p)+min(eigs_p));
alpha_opt=2/(max(eigs)+min(eigs));

[x3, iter3, incr3] = prec_rich_method(A, b, eye(n), alpha_opt, x0, tol, max_it);
[x4, iter4, incr4] = prec_rich_method(A, b, Li*Ui, alpha_opt_p, x0, tol, max_it);
