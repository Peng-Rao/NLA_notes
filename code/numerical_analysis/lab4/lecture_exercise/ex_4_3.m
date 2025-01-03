%% Excercise 4.3
clc
clear all
close all
%% Apply the Matlab® command lu and compute the LU factorization of the matrices
A = [50 1 3;
      1 6 0;
      3 0 1];
B = [4 1 1;
     4 1 2;
     1 0 15];

[La, Ua] = lu(A);
[Lb, Ub] = lu(B);
% Let us check if the matrices L and U are as we expect them to be.

La
Ua
Lb
Ub

% The matrix B does not admit a unique LU factorization because there is a singular
% principal submatrix. Pivoting is required to restore the uniquess of the factorization
[La, Ua,Pa] = lu(A);
[Lb, Ub,Pb] = lu(B);

% Pa is the identity matrix as expect. Pb is different from I.
Pa
Pb

% Compute the determinant of the A,B without the command det
% in the case of matrix A, let procede as in ex 4.2
detA= prod(diag(Ua))
%check
detA_mat=det(A)
% in the case of B, notice that P could have determinanti =+-1, therefore
% det(P)det(B)=det(Ub)---> det(B)= (det(Ub)/det(P))
detb=prod(diag(Ub))/det(Pb)
detV_mat=det(B)
%%  Solve the systems Ax = a,Bx = b. Choose the vectors a, b, such that
% the solution of the system is xex = [1, 1, 1]'
xex = [1; 1; 1];
b = A*xex;


y = forward_substitution(La, b);
x = backward_substitution(Ua, y);

% Finally, let's check if x is equal to xex:

x

% Now with matrix B
b = B*xex;

y = forward_substitution(Lb, Pb*b);
x = backward_substitution(Ub, y);
x
