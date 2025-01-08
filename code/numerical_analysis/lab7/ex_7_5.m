clc;clear;close all;
%% 1
 f=@(x)[(x(1)^2 -1) ./ (x(1)^2 + 1);
      (x(1)^2 + x(2)^2 -1) ./ (x(1)^2 + x(2)^2 + 1)];
 J=@(x)[(4*x(1))./(x(1)^2 + 1)^2, 0;
   (4*x(1))./(x(1)^2 + x(2)^2 + 1).^2, (4*x(2))/(x(1)^2 + x(2)^2 + 1)^2];

%% Use the provided newtonsys.m function to calculate the solution of the proposed nonlinear system.
tol=1e-6; Nmax=1000;
        
x0=[1.5;0.5];
[x1,~,iter1] = newtonsys(f,J,x0,tol,Nmax,2);
fprintf("Number of iterations: %g\n", iter1)
fprintf("Solution with x0=[%g,%g]\n", x0);
fprintf("x1=%d\nx2=%d\n", x1)
%check
%fsolve(f, x0)
x0=[-1.5;0.5];

[x2,~,iter2] = newtonsys(f,J,x0,tol,Nmax,2);
fprintf("Number of iterations: %g\n", iter2)
fprintf("Solution with x0=[%g,%g]\n", x0);
fprintf("x1=%d\nx2=%d\n", x2)
%check
% fsolve(f, x0)

%% Comment
% In both cases, Newton's method converges, as the number of iterations is lower than the set maximum, and no error message is displayed.
% The nonlinear system considered has (at least) two distinct roots: [1,0]
% and [-1,0], which can be easily verified by hand.
% Depending on the initial iterate, Newton's method converges to one root rather than the other.

%% 4
x0=[-1.5;0.5];

[~,~,iter2,~,x_vec] = newtonsys(f,J,x0,tol,Nmax,2);
alpha=[-1;0];
for ii=1:iter2
    err(ii)=norm(x_vec(:,ii)-alpha);
end
fprintf("error is:\n");
disp(err(1:4))

%% 5
x0=[3;0.5];

[x3,~,iter3] = newtonsys(f,J,x0,tol,Nmax,2);
fprintf("Number of iterations: %g\n", iter3)
fprintf("Solution with x0=[%g,%g]\n", x0);
fprintf("x1=%d\nx2=%d\n", x3)
fprintf("Newton does not converge!")
% In this case, Newton's method does not converge. 
% This is not in contradiction with the theory, which states that 
% Newton's method for nonlinear systems is a local method, and therefore 
% only converges when the initial iterate is sufficiently close to a root of the system of equations.
% In particular, in this case, the algorithm halts after only 8 iterations
% due to the determinant of the Jacobian matrix becoming zero 
% (as indicated by the warnings printed by Matlab, which inform that the Jacobian matrix is,
% within rounding errors, a singular matrix).