clear; close all;

%% define the matrix
format long
n = 20;

% create diagonal
main_diag = 10 * ones(1, n);
second_diag = -4 * ones(1, n - 1);
third_diag = -1 * ones(1, n - 2);
A = diag(main_diag) + diag(second_diag, -1) + diag(second_diag, 1) + diag(third_diag, -2) + diag(third_diag, 2);
b = ones(20, 1);

%% a) Solve the proposed system by the stationary Richardson method, with alpha = 0.25
alpha = 0.25;
x_0 = b;
tol = 1e-3;
max_it = 500;
P = eye(size(A));

[x_a, iter_a, residual_a] = richprec(A, b, P, alpha, x_0, max_it, tol);

disp("iteration: ");
disp(iter_a);
res_a = (b - A * x_a) / norm(b);
disp("the third component of residual");
disp(res_a(3));

% Comment
% As can be seen from this result and the number of iterations taken by the method 
% (500, which is the maximum number of iterations), 
% we deduce that the Richardson method did not converge
% within the maximum number of iterations
% and that the solution is diverging. 
% This could have been anticipated beforehand, 
% as the relaxation parameter used,alpha=0.25
% is greater than the maximum allowed value

eigs = eig(A);
% alpha_max= 2*min((real(eigs)./(abs(eigs).^2)));
% Since the eigenvalues are real (you can check with isreal(eigs))
alpha_max = 2 / max(eigs);
fprintf("Maximum Alpha: %d\n", alpha_max)

%% c) with the optimal value of the parameter alpha

alpha = 2 / (max(abs(eig(A))) + min(abs(eig(A))));
[x_b, iter_b, residual_b] = richprec(A, b, P, alpha, x_0, max_it, tol);

disp("iteration: ");
disp(iter_b);
res_b = (b - A * x_b) / norm(b);
disp("the third component of residual");
disp(res_b(3));

% Comment
% In this case, the solution converges within the maximum number of iterations.
% The convergence here is ensured by using a value of alpha such that 
% 0<alpha<2/lamda_max
% In particular, alpha_opt guarantees the least number of iterations.

%% d) using alpha = 0.84 using tridiagonal preconditioner
P = diag(10 * ones(20, 1)) + diag(-5 * ones(20 - 1, 1), -1) + diag(-5 * ones(20 - 1, 1), 1);
alpha = 0.84;
[x_c, iter_c, residual_c] = richprec(A, b, P, alpha, x_0, max_it, tol);

disp("iteration: ");
disp(iter_c);
res_c = (b - A * x_c) / norm(b);
disp("the third component of residual");
disp(res_c(3));

% Comment
% In this case, the Richardson method is very fast.
% From theory, we know that if the preconditioner is a good approximation of A, 
% then the number of iterations decreases. 
% This is the case here, as P has the same diagonal as A,
% and the diagonals just above and below it contain the sums of the other diagonals of A.
% Furthermore, from theory, we know that if the linear system associated 
% with P (for calculating the residual) is easy to solve, 
% then the total cost is significantly reduced. 
% This should be our case since P has a simple structure (tridiagonal).