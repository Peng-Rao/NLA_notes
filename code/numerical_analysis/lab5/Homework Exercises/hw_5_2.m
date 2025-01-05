%% Homework 5.2
clc
clear all
close all
%% Compute the condition number and the determinant of the following
%  matrices
A = diag(0.1*ones(15,1));
B = triu(rand(15),14)*1e5 + diag(0.1*ones(15,1));

det(A)
cond(A)

det(B)
cond(B)

% The two matrices have the same determinant but B is very badly
% conditioned. Thus, we cannot say that the determinant is a good indicator
% for the condition number of a matrix.
