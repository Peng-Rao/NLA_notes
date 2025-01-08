%% Exercise 9.2
clear all; close all; clc;

%% First Function f1
f1  = @(x) 1-(4*x.^2)/pi^2 + (4*x.^3)/pi^3 - x.^4/pi^4;
n  = 50;
jj  = [0:n];
h  = 2*pi/(n+1);
xj = jj*h;


F=interpft(f1(xj),1000);
x = linspace (0, 2*pi, 1000).';
figure
plot (x, F,'LineWidth',2)
hold on
plot(x, f1(x), xj, f1(xj), 'x')
title("f=$1-\frac{4x^2}{\pi^2} + \frac{4x.^3}{\pi^3} - \frac{x^4}{\pi^4}$", 'Interpreter','latex','FontSize',18)
legend('trigonometric interpolant', 'true function','nodes values','Location','north')

%Convergence study
err=[];
for iM=1:6
    M=2.^iM;
    n=2*M;
    jj  = [0:n];
    h  = 2*pi/(n+1);
    xj = jj*h; 
    F=interpft(f1(xj),1000);
    x = linspace (0, 2*pi, 1000);
    err=[err norm(f1(x)-F,inf)];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, 1./(nvec.^2))
legend("err", 'O(n^-2)')
%% continuous function
f2  = @(x) interp1 ([0 2*pi/3 4*pi/3 2*pi], [0 1 -1 0], x, 'linear');
% Compute the coefficients for the trigonometric itnerpolation
n  = 50;
jj  = [0:n];
h  = 2*pi/(n+1);
xj = jj*h;



F=interpft(f2(xj),1000);
x = linspace (0, 2*pi, 1000).';
figure
plot (x, F,'LineWidth',2)
hold on
plot(x, f2(x), xj, f2(xj), 'x')
title("non derivable function", 'Interpreter','latex','FontSize',18)
legend('trigonometric interpolant', 'true function','nodes values','Location','southeast')

%Convergence study
err=[];
for iM=1:6
    M=2.^iM;
    n=2*M;
    jj  = [0:n];
    h  = 2*pi/(n+1);
    xj = jj*h; 
    F=interpft(f2(xj),1000);
    x = linspace (0, 2*pi, 1000);
    err=[err norm(f2(x)-F, inf)];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, 1./(nvec))
legend("err", 'O(n)')
%% step function
f3  = @(x) 1.0 .* (x > pi/2 & x < 3*pi/2);
n  = 50;
jj  = [0:n];
h  = 2*pi/(n+1);
xj = jj*h;


F=interpft(f3(xj),1000);
x = linspace (0, 2*pi, 1000).';
figure
plot (x, F,'LineWidth',2)
hold on
plot(x, f3(x), xj, f3(xj), 'x')
title("$f=1.0 (x > \pi/2 \,and\, x < 3\pi/2)$", 'Interpreter','latex','FontSize',18)
legend('trigonometric interpolant', 'true function','nodes values','Location','south')
% Property editing
positionPropObjs = findobj(gcf, "-property", "Position");
positionPropObjs(2).Position = [0.3339 0.1429 0.2894, 0.0959];
%Convergence study
err=[];
for iM=1:6
    M=2.^iM;
    n=2*M;
    jj  = [0:n];
    h  = 2*pi/(n+1);
    xj = jj*h; 
    F=interpft(f3(xj),1000);
    x = linspace (0, 2*pi, 1000).';
    err=[err max(abs(f3(x)'-F))];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, 1./(nvec))
legend("err", 'O(n)')
%% step function
f4 = @(x) sin (x + cos (5*x));
n  = 50;
jj  = [0:n];
h  = 2*pi/(n+1);
xj = jj*h;


F=interpft(f4(xj),1000);
x = linspace (0, 2*pi, 1000).';
figure
plot (x, F,'LineWidth',2)
hold on
plot(x, f4(x), xj, f4(xj), 'x')
title("f=$\sin (x + \cos (5x)$", 'Interpreter','latex','FontSize',18)
legend('trigonometric interpolant', 'true function','nodes values','Location','southwest')

%Convergence study
err=[];
for iM=1:6
    M=2.^iM;
    n=2*M;
    jj  = [0:n];
    h  = 2*pi/(n+1);
    xj = jj*h; 
    F=interpft(f4(xj),1000);
    x = linspace (0, 2*pi, 1000);
    err=[err norm(f4(x)-F,inf)];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, exp(-0.2*nvec))
legend("err", 'O(exp(-n)')
