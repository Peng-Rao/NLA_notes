%% Exercise 7.2
%% Point A
clc;clear;
% System 1
%A = [2 -1; -1 2];
%b = [1 1]';

% % System 2
A = [1 -1; -1 20];
 %b = [0 19]';
%
% % System 3
 %A = [3 0; 0 3];
 %b = [3 3]';

%	All the matrices are symmetric and positive definite: the first and third are
% strictly diagonally dominant; for the second sysyem we need to compute the eigenvalues
if all(eig(A)>0)
    fprintf("A is positive definite.\n")
end
%% Point B
%help meshgrid
%help contour

% Vectors for plotting the isolines
x = -2:0.01:2;
y = x;
PHI = @(x1,x2) 0.5*x1.^2*A(1,1)+...
             0.5*x2.^2*A(2,2)+...
             x1.*x2*A(1,2)-...
             x1*b(1)-x2*b(2);

% Contour
[X,Y] = meshgrid(x,y);
clear x y;
%figure('Name','Iso-lines')
%contour(X, Y, PHI(X,Y));


%%
P=eye(2);
x0=[-2,2]';
max_it=100; tol=1e-3;
[x1, it1, res1, XK1] = gradprec(A,b,P, x0,max_it, tol);
figure
contour(X,Y,PHI(X,Y),15);
hold on
for ii=1:it1
    x1=XK1(1,ii); x2=XK1(2,ii);
    contour(X,Y,PHI(X,Y),[PHI(x1,x2) PHI(x1,x2)]);
end
plot(XK1(1,:),XK1(2,:),'*-','linewidth',2);
fprintf("Iterations require with non preconditioned gradient Method: %g\n", it1);
% Comments
% The directions of each update are always normal to the contour lines: indeed, this is a property of the gradient direction.
% In the first case the ellipse is relatively not stretched. Recall that the ratio 
% between the lengths of the axes of the ellipses is the ratio between the maximum and minimum 
% eigenvalues of the matrix (= conditioning number of the matrix). Convergence is good.
% In the second case the eigenvalues are very different and the isolines result to be very stretched ellipses.
% The ratio between the eigenvalues is high. The gradient method is not efficient since many steps are too short.
% In the third case the isolines are circumferences and the solution is obtained
% in just one step, since in any point on a circonference the normal goes to the center.

