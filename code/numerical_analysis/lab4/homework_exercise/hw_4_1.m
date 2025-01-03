%% Homework 4.2
clc
clear all
close all

E = [4 1 1 1 5;
     4 1 2 0 0;
     1 0 15 5 1;
     0 2 4 10 2;
     3 1 2 4 20];

b = [12 19 22 18 30]';

n = size(E,1);
%% Verify with Matlab that the sufficient conditions for the existence and
% uniqueness of the LU decomposition without pivoting are not fulfilled
% by matrix E

% Let calculate the determinant of the all the minor fo the matrix E

for i = 1:n-1
    det(E(1:i, 1:i))
end

% Since one of the minor determinants is equal to zero, the LU
% factorization without pivoting does not exist!

%% Compute the LU of matrix E with the Matlab command lu and verify
% if pivoting takes place with the Matlab command spy.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ATTENTION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % if a matrix E does not admit a LU factorization and you
 % call lu command without the output P, matlab does not
 % return the lu factorization of P*E but a factorization
 % of E which is not lower-upper triangular
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[L, U] = lu(E);

L % is not triangular!
figure()
% spy plots the sparsity pattern of matrix L.
% Nonzero values are colored while zero values are white
spy(L)
U

[L, U, P] = lu(E);

L
figure()
spy(L)
U
P % is not the identity matrix => pivoting is needed

%% Solve the system Ex = b by using the LU decomposition at the
% previous item.
% backward substitutions (you can use also  backward_substitution.m)
y = L\(P*b);
% forward substitutions (you can use also forward_substitution.m)
x = U\y
xex = E\b
