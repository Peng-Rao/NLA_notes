% EXERICES 7.4
%% closes all figures whose handles are visible

clear
close all
clc

%Function Definition: vectorial function handle
F = @(x) [x(1).^2+x(2).^2-1;
          sin(pi*x(1)/2)+x(2).^3];
%Jacobian Definition: vectorial function handle
J = @(x) [2*x(1), 2*x(2);
          cos(pi*x(1)/2)*pi/2, 3*x(2).^2];

nmax = 200;
tol = 1e-10;
x0 = [-1;-1];

[x,res,niter,difv,x_vect] = newtonsys(F,J,x0,tol,nmax,2);
format long
x
niter




