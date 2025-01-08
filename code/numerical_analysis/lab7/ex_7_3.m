%% Excercise 7.3
clear;close all;clc

%% a)
A = [3 2;
     2 6];
b = [2;-8];
x_ex = [2;-2];

% Phi=1/2 * x^T*A*x+x^T*b
Phi = @(x1,x2) 0.5*x1.^2*A(1,1)+...
             0.5*x2.^2*A(2,2)+...
             x1.*x2*A(1,2)-...
             x1*b(1)-x2*b(2);
x = linspace(-5, 5, 1001);
y = linspace(-5, 5, 1001);
[X,Y] = meshgrid(x,y);
figure
contour(X,Y,Phi(X,Y));

%% b)
x0 = [-2;2];
tol = 1e-6;
max_it = 1000;

P=eye(2);
[x1, it1, res1, XK1] = gradprec(A,b,P, x0,max_it, tol);
figure
contour(X,Y,Phi(X,Y),15);
hold on
for ii=1:it1
    x1=XK1(1,ii); x2=XK1(2,ii);
    contour(X,Y,Phi(X,Y),[Phi(x1,x2) Phi(x1,x2)]);
end
plot(XK1(1,:),XK1(2,:),'*-','linewidth',2);
fprintf("Iterations require with non preconditioned gradient Method: %g\n", it1);
%% c)
P = diag(diag(A));
[x2, it2, res2, XK2] = gradprec(A,b,P, x0,max_it, tol);
figure
contour(X,Y,Phi(X,Y),15);
hold on
for ii=1:it2
    x1=XK2(1,ii); x2=XK2(2,ii);
    contour(X,Y,Phi(X,Y),[Phi(x1,x2) Phi(x1,x2)]);
end
plot(XK2(1,:),XK2(2,:),'*-','linewidth',2);
fprintf("Iterations require with preconditioned gradient Method: %g\n", it2);

%% d)
[x3,it3,XK3,res3] = ConjGrad(A,b,x0,max_it,tol);
figure
contour(X,Y,Phi(X,Y),15);
hold on
for ii=1:it3
    x1=XK3(1,ii); x2=XK3(2,ii);
    contour(X,Y,Phi(X,Y),[Phi(x1,x2) Phi(x1,x2)]);
end
plot(XK3(1,:),XK3(2,:),'*-','linewidth',2);
[xk_pcg1,flag1,relres1,k1] = pcg(A,b,tol,max_it,eye(2));
fprintf("Iterations require with non PCG : %g\n", k1);

%% e)
[xk_pcg2,flag2,relres2,k2] = pcg(A,b,tol,max_it,P);
fprintf("Iterations require with preconditioned gradient Method: %g\n", k2);


