clc;clear;close all;
%% Point a: build A
n=7; 
A=diag(ones(n, 1));
A(1:end, end)=1;
A(end, :)=1:n;
%%%%%%%%%%%%%%%%%
%Check
fprintf("A is:\n")
disp(A)

%% Point b: LU factorization
[L, U, P]=lu(A);

fprintf("L is:\n")
disp(L)
fprintf("U is:\n")
disp(U)

%% Point c
figure("Name",sprintf("Pattern of Matrix P"))
spy(P)
% We observe that pivoting has been performed; in particular, 
% the last row of A has become the second row, 
% and the rows from 2 to 6 of A have become rows 3 to 7. 
% See also Figure 1.
figure("Name",sprintf("Pattern of Matrix A"))
spy(A)
figure("Name",sprintf("Pattern of Matrix L"))
spy(L)
figure("Name",sprintf("Pattern of Matrix U"))
spy(U)
% We also observe the occurrence of the fill-in phenomenon,
% as the matrix U is full despite the sparsity 
% of matrix A. See Figure 2 and 3.

%% Point d
b=[1; zeros(n-1, 1)];


y=forward_substitution(L, P*b);
x=backward_substitution(U, y);

fprintf("The solution is x= \n");
disp(x)
% Check
% disp(A\b)

%% Point e
err=[];
a=1.1;
for n=[20 30 40]
    A=diag(ones(n, 1));
    A(1:end, end)=1;
    v = [1.1; ones(n-1,1)];
    A(end, :)=v;
    tmp=a/(a+n-3);
    xex=[1-tmp ; -repmat(tmp, n-2,1); tmp];
    %xex=[1-tmp; -tmp*ones(n-2,1); tmp];
    [L, U, P]=lu(A);
    
    b=[1; zeros(n-1, 1)];

    y=forward_substitution(L, P*b);
    x_comp=backward_substitution(U, y);
    err_n=norm(xex-x_comp)/norm(xex);
    err=[err err_n];

end
err