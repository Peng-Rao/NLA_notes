%% Excercise 7.1
A = [ 2 -1  0  1;
     -1  4  2 -1;
      0  2  2  1;
      1 -1  1  5];
b = [2 4 5 6]';

% The coefficient matrix is symmetric but we cannot determine from its
% structure if it is also positive definite since it is not diagonally dominant 
% (notice in particular the third row). 
% However, the eigenvalues of A are positive, so we can conclude that the matrix 
% is positive definite and we can apply gradient method.

if all(eig(A)>0)
    fprintf("A is positive definite.\n")
end


x0 = zeros(4,1);
tol = 1e-9;
iter_max = 1000;
P = eye(size(A));
[x, iter, err] = gradprec(A,b,P, x0,iter_max, tol);
x
iter
alpha=2/(min(eig(A))+ max(eig(A)));
% Comparison with non-preconditioned richardson
[x, iter, incr] = richprec(A,b,P, alpha, x0,iter_max, tol);
% Check
x = A\b
