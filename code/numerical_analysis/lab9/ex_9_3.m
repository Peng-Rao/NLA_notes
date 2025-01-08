%% Exercise 9.3
clear all; close all; clc;
f  = @(x) cos (5*x + sin(5*x));

n  = 50;
I=[0,2*pi];
[~, a,b]=int_trigonometrico(I,n,f);
x = linspace (0, 2*pi, 1000).';
F = a(1)/2;
for ii = 1 : n/2
  Fkk= a(ii+1) * cos (ii * x) + b(ii) * sin (ii * x);
  F=F+Fkk; 
end

figure
plot (x, F,'LineWidth',2)
hold on
plot(x, f(x), 'x-')
title("f=$ \cos (5x + \sin (5x))$", 'Interpreter','latex','FontSize',18)
legend('trigonometric interpolant', 'true function','Location','southwest')

%% Convergence study
err=[];
for iM=1:6
    M=2.^iM;
    n=2*M;
    [~, a,b]=int_trigonometrico(I,n,f);
    x = linspace (0, 2*pi, 1000).';
    F = a(1)/2;
    for ii = 1 : n/2
        Fkk= a(ii+1) * cos (ii * x) + b(ii) * sin (ii * x);
        F=F+Fkk; 
    end
    err=[err max(abs(f(x)-F))];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, exp(-0.2*nvec))
legend("err", 'O(exp(-n)')
%% point C
degree=15;
xnodes=linspace(0,2*pi,degree+1);
fnodes=f(xnodes);
pp=polyfit(xnodes,fnodes, degree);
y=polyval(pp, x);
figure
plot (x, F,'LineWidth',2)
hold on
plot(x, y,'LineWidth',2)
plot(x, f(x))
title("f=$  \cos (5x + \sin (5x))$", 'Interpreter','latex','FontSize',18)
legend('trigonometric interpolant', 'Lagrange Polynomial','true function','Location','southwest')

errLagrange=max(abs(y-f(x)));
errFourier=max(abs(F-f(x)));
[errLagrange errFourier]
