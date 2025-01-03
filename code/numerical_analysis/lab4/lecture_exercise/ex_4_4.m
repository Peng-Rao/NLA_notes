%% Homework 4.1
clc
clear all
close all
%% Use the LU decomposition of matrix A to solve the system. Use both
%  the functions implemented and the lu MATLAB/Octave command.
A = [12 5 -8 -5;
     -4 -4 8 -6;
      4 2 -3 0;
     0 -1 2 -4;];

b = [4 -6 3 -3]';

[L, U] = lu(A)


y1 = forward_substitution(L, b);
x1 = backward_substitution(U, y1)

x1_mat=A\b
% Compute the determinant of A using the LU decomposition
detA = prod(diag(U))
det(A)

c = [-22 -12 -1 -11]';

y2 = forward_substitution(L, c);
x2 = backward_substitution(U, y2)

x2_mat=A\c

% The solution of the system A*x2 = c is obtained without a new
% factorization, since we stored the matrices L and U the first time we
% solved the system with b. This factorization is indeed useful everytime
% the matrix A does not change and we have to solve several linear systems
% with different right-hand sides.


