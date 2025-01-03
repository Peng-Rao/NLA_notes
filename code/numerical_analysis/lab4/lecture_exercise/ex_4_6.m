%% Excercise 4.5
clc
clear all
close all

A = [44 15 29 26 119;
     15 33 32 18 15;
     29 32 252 112 73;
     26 18 112 124 90;
     119 15 73 90 430];
b = [1 1 1 1 1]';

%Verify that the Cholesky decomposition can be applied to matrix A
any(eig(A)<=0)

% All the eigenvalues are strictly positive, so A is positive definite. The
% simmetry comes from the fact that eig(A) is a real vector and indeed
(A'==A)

% Mat_R upper triangular
Mat_R = chol(A);
% My_H upper triangular
My_H = MyChol(A)

% Now, let's solve H^T*H*x=b, with H upper triangular

y = My_H'\b;
x = My_H\y

% Let us compare the result obtained with the one furnished by the
% backslash implemented in Matlab.
xex = A\b
