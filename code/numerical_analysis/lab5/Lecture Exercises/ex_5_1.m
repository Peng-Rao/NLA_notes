%% Excercise 5.1
clc
clear all
close all

a = [1:10]';
c = [10:19]';
e = [102:111]';
n = length(a);

A_sparse = spdiags([e a c], [-1 0 1], n, n)
% alternative way to create A as a sparse and full matrix
% A = diag(1:10) + diag(102:110,-1) + diag(11:19, 1)
% Asparse = sparse(A)

xex = ones(n,1);
b = A_sparse*xex

% Compare memory usage of the sparse and full format:
A_full = full(A_sparse)
whos % memory usage of the sparse format is less than the full format

clear Afull

[L,U,x] = thomas(A_sparse,b);
x
