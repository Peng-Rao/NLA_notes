%% Exercise 6.4
clc;clear; close all;
format long 
%% Build the matrix
n=20;
A = -diag(ones(n-2,1), -2) - 4* diag(ones(n-1,1), -1) + 10*diag(ones(n, 1), 0)...
    -diag(ones(n-2,1), +2) - 4* diag(ones(n-1,1), +1);
%disp(A)
b=ones(n,1);
%% Solve Using the non preconditioned Richardson Method
alpha=0.25; x0=b; tol=1e-3; nmax=500;

[x, iter, res] = richardson(A, b,x0, alpha, tol, nmax);
fprintf("Iterations: %d\n",iter);
fprintf("Third component of x: %d\n", x(3))  
res_xn=(b-A*x)/norm(b);
fprintf("Third component of the residual of x: %d\n", res_xn(3))

%% Point b
% The residual is:
%res=norm(b-A*x)/norm(b);
fprintf("Normalized Residual of x in 2-norm: %d\n", res(end))
% As can be seen from this result and the number of iterations taken by the method 
% (500, which is the maximum number of iterations), 
% we deduce that the Richardson method did not converge
% within the maximum number of iterations
% and that the solution is diverging. 
% This could have been anticipated beforehand, 
% as the relaxation parameter used,alpha=0.25
% is greater than the maximum allowed value
eigs=eig(A);
% alpha_max= 2*min((real(eigs)./(abs(eigs).^2)));
% Since the eigenvalues are real (you can check with isreal(eigs))
alpha_max=2/max(eigs);
fprintf("Maximum Alpha: %d\n",alpha_max)

%% Point c
alpha_opt=2/(max(eigs)+min(eigs));
fprintf("Optimal Alpha: %d\n",alpha_opt)
[x2, iter2, incr2] = richardson(A, b,x0, alpha_opt,tol, nmax);
fprintf("Iterations: %d\n",iter2);

% In this case, the solution converges within the maximum number of iterations.
% The convergence here is ensured by using a value of alpha such that 
% 0<alpha<2/lamda_max
% In particular, alpha_opt guarantees the least number of iterations.

%% Point d
alpha2= 0.84; 
P=-5*diag( ones(n-1,1), -1) + 10*diag( ones(n,1), 0) - 5*diag( ones(n-1,1), +1);
[x3, iter3, incr3] = richprec(A, b, P, alpha2, x0,nmax, tol);
fprintf("Iterations: %d\n",iter3);
% In this case, the Richardson method is very fast.
% From theory, we know that if the preconditioner is a good approximation of A, 
% then the number of iterations decreases. 
% This is the case here, as P has the same diagonal as A,
% and the diagonals just above and below it contain the sums of the other diagonals of A.
% Furthermore, from theory, we know that if the linear system associated 
% with P (for calculating the residual) is easy to solve, 
% then the total cost is significantly reduced. 
% This should be our case since P has a simple structure (tridiagonal).

