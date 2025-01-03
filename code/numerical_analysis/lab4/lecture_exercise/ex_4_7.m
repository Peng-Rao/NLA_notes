clc;clear;close all

A=[10 0 3 0; 0 5 0 -2; 3 0 5 0; 0 -2 0 2];
b=2*ones(4, 1);

if( all(all(A'==A)) && all(eig(A)>0))
    fprintf("Cholesky HPs ok\n");
end

R=chol(A);
y=R'\b;
x=R\y

disp(A\b)

detA= prod(diag(R))^2
disp(det(A))