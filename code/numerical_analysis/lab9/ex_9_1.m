%% Exercise 9.1
clear all; close all; clc;

M  = 25; k  = [-M:M]';
n  = 2*M;
jj  = [0:n];
h  = 2*pi/(n+1);
xj = jj*h;
%% First Function f1
f1  = @(x) 1-(4*x.^2)/pi^2 + (4*x.^3)/pi^3 - x.^4/pi^4;
% Compute the coefficients for the trigonometric itnerpolation

c=discrete_fourier_transform(xj, f1(xj)',k);

a = c(M+2:end) + c(M:-1:1);
b = i * (c(M+2:end) - c(M:-1:1));
a0= c(M+1) + c(M+1);
% Compute the interpolant
x = linspace (0, 2*pi, 1000).';

F = a0/2;
for ii = 1 : M
  Fkk= a(ii) * cos (ii * x) + b(ii) * sin (ii * x);
  F=F+Fkk; 
end
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
    k  = [-M:M]';
    jj  = [0:n];
    h  = 2*pi/(n+1);
    xj = jj*h;
    c=discrete_fourier_transform(xj, f1(xj)',k);

    a = c(M+2:end) + c(M:-1:1);
    b = i * (c(M+2:end) - c(M:-1:1));
    a0= c(M+1) + c(M+1);
    % Compute the interpolant
    x = linspace (0, 2*pi, 1000).';

    F = a0/2;
    for ii = 1 : M
      Fkk= a(ii) * cos (ii * x) + b(ii) * sin (ii * x);
      F=F+Fkk; 
    end
    err=[err norm(f1(x)-F, inf)];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, 1./nvec.^2)
legend("err", 'O(n^-2)')
%% continuous function
f2  = @(x) interp1 ([0 2*pi/3 4*pi/3 2*pi], [0 1 -1 0], x, 'linear');
% Compute the coefficients for the trigonometric itnerpolation

c=discrete_fourier_transform(xj, f2(xj)',k);

a = c(M+2:end) + c(M:-1:1);
b = i * (c(M+2:end) - c(M:-1:1));
a0= c(M+1) + c(M+1);
% Compute the interpolant
x = linspace (0, 2*pi, 1000).';

F = a0/2;
for ii = 1 : M
  Fkk= a(ii) * cos (ii * x) + b(ii) * sin (ii * x);
  F=F+Fkk; 
end
figure
plot (x, F,'LineWidth',2)
hold on
plot(x, f2(x), xj, f2(xj), 'x')
title("non derivable function", 'Interpreter','latex','FontSize',18)
legend('trigonometric interpolant', 'true function','nodes values','Location','southwest')

%Convergence study
err=[];

for iM=1:6
    M=2.^iM;
    n=2*M;
    k  = [-M:M]';
    jj  = [0:n];
    h  = 2*pi/(n+1);
    xj = jj*h;
    c=discrete_fourier_transform(xj, f2(xj)',k);

    a = c(M+2:end) + c(M:-1:1);
    b = i * (c(M+2:end) - c(M:-1:1));
    a0= c(M+1) + c(M+1);
    % Compute the interpolant
    x = linspace (0, 2*pi, 1000).';

    F = a0/2;
    for ii = 1 : M
      Fkk= a(ii) * cos (ii * x) + b(ii) * sin (ii * x);
      F=F+Fkk; 
    end
    err=[err max(abs(f2(x)-F))];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, 1./nvec)
legend("err", 'O(n)')
%% step function
f3  = @(x) 1.0 .* (x > pi/2 & x < 3*pi/2);
% Compute the coefficients for the trigonometric itnerpolation

c=discrete_fourier_transform(xj, f3(xj)',k);

a = c(M+2:end) + c(M:-1:1);
b = i * (c(M+2:end) - c(M:-1:1));
a0= c(M+1) + c(M+1);
% Compute the interpolant
x = linspace (0, 2*pi, 1000).';

F = a0/2;
for ii = 1 : M
  Fkk= a(ii) * cos (ii * x) + b(ii) * sin (ii * x);
  F=F+Fkk; 
end
figure
plot (x, F,'LineWidth',2)
hold on
plot(x, f3(x), xj, f3(xj), 'x')
title("f=$1-\frac{4x^2}{\pi^2} + \frac{4x.^3}{\pi^3} - \frac{x^4}{\pi^4}$", 'Interpreter','latex','FontSize',18)
legend('trigonometric interpolant', 'true function','nodes values','Location','south')
legend("Position", [0.33388,0.14291,0.28939,0.095918])

% Property editing
positionPropObjs = findobj(gcf, "-property", "Position");
positionPropObjs(2).Position = [0.3339 0.1429 0.2894, 0.0959];
%Convergence study
err=[];

for iM=1:6
    M=2.^iM;
    n=2*M;
    k  = [-M:M]';
    jj  = [0:n];
    h  = 2*pi/(n+1);
    xj = jj*h;
    c=discrete_fourier_transform(xj, f3(xj)',k);

    a = c(M+2:end) + c(M:-1:1);
    b = i * (c(M+2:end) - c(M:-1:1));
    a0= c(M+1) + c(M+1);
    % Compute the interpolant
    x = linspace (0, 2*pi, 1000).';

    F = a0/2;
    for ii = 1 : M
      Fkk= a(ii) * cos (ii * x) + b(ii) * sin (ii * x);
      F=F+Fkk; 
    end
    err=[err max(abs(f3(x)-F))];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, 1./nvec)
legend("err", 'O(n)','Location','southwest')

%% C^\infty function
f4 = @(x) sin (x + cos (5*x));
% Compute the coefficients for the trigonometric itnerpolation

c=discrete_fourier_transform(xj, f4(xj)',k);

a = c(M+2:end) + c(M:-1:1);
b = i * (c(M+2:end) - c(M:-1:1));
a0= c(M+1) + c(M+1);
% Compute the interpolant
x = linspace (0, 2*pi, 1000).';

F = a0/2;
for ii = 1 : M
  Fkk= a(ii) * cos (ii * x) + b(ii) * sin (ii * x);
  F=F+Fkk; 
end
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
    k  = [-M:M]';
    jj  = [0:n];
    h  = 2*pi/(n+1);
    xj = jj*h;
    c=discrete_fourier_transform(xj, f4(xj)',k);

    a = c(M+2:end) + c(M:-1:1);
    b = i * (c(M+2:end) - c(M:-1:1));
    a0= c(M+1) + c(M+1);
    % Compute the interpolant
    x = linspace (0, 2*pi, 1000).';

    F = a0/2;
    for ii = 1 : M
      Fkk= a(ii) * cos (ii * x) + b(ii) * sin (ii * x);
      F=F+Fkk; 
    end
    err=[err norm((f4(x)-F),inf)];

end

figure
nvec=2*2.^[1:6];
loglog(nvec, err)
hold on
loglog(nvec, exp(-0.2*nvec))
legend("err", 'O(exp(-n)')

