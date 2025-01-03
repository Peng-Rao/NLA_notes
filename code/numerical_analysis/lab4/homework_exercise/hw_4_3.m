%% Homework 4.5
clc
clear all
close all

a = 2;
b = 1;
n = 10;
A = diag(a * ones(n, 1)) + diag(b * ones(n-1,1), -1) + diag(b * ones(n-1,1), +1);
%% Verify with MATLAB that A_10 is a symmetric positive definite matrix

eig(A)
% All the eigenvalues are positive and it is trivial to prove the simmetry.

%% Provide the form of the matrix V10 such that A10 = VT10 V10
V = chol(A)
format short e
V'*V - A
% V is bidiagonal since Cholesky decomposition preserves the pattern of the
% matrix.

