%% Excercise 4.2
clc
clear all
close all
%%  Compute the solution of the system Ax = b using the LU decomposition of matrix A

A = [2 10 4 0;
     1  0 2 2;
     1 4 0 2;
     1 2 1 1];
b = [10 1 3 3]';

[L, U] = lu(A);
% In this case it is not essential to include the matrix P among the output
% variables in order to have L in the form of a lower triangular matrix
% with L_ii = 1 for each i.

y=forward_substitution(L, b)
x=backward_substitution(U,y)


% Check
y = L \ b; %forward
x = U \ y  %backward
% Check by solving the sysyem directly
A \ b

% Thanks to the Binet-Cauchy formula, we have, for generic square matrices,
% det(A*B) = det(A)*det(B).
% In our case, since A = L*U, det(A) = det(L*U) = det(L)*det(U).
% However L_ii = 1 for each i, so det(L) = 1
% => det(A) = det(U).

%% Find the determinant of A without using the command det.
detA = prod(diag(U))

% Check with the command det
det(A)
