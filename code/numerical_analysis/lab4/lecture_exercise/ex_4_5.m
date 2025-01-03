%% Excercise 4.4
% Write a function [InvA]=MyInv(A) that computes the inverse InvA of a
% generic square matrix A.
% Then use the function MyInv to compute the inverse of the matrix A in the
% previous exercise. Compare the result with the output provided by Matlab
% with command inv.

format shortG
A = [2 10 4 0;
     1  0 2 2;
     1 4 0 2;
     1 2 1 1];

InvA = MyInv(A)
InvA_mat=inv(A)
