% EXERICES 2.2
%% closes all figures whose handles are visible

close all
clear all
clc
%% PLOT THE FUNCTION f
% define the function f
f = @(x) sin(x) .* (1 - x) .^ 2;
% define the derivative of f
df = @(x) cos(x) .* (1 - x) .^ 2 - 2 * sin(x) .* (1 - x);
% plot
a = -0.5; b = 1.5;
x_plot = linspace(a, b, 1000);
figure
plot(x_plot, f(x_plot), 'LineWidth', 2);
hold on
plot(x_plot, zeros(size(x_plot)))
grid on
xlim([a, b])
xlabel("x", 'FontSize', 18)
ylabel("f(x)", 'FontSize', 18)
str = sprintf('Function f in [%d, %d]', a, b);
title(str, 'FontSize', 15)
set(gca, 'FontSize', 16)
set(gca, 'LineWidth', 1.5)

% Plot df
figure
plot(x_plot, df(x_plot), 'LineWidth', 2);
hold on
plot(x_plot, zeros(size(x_plot)))
grid on
xlim([a, b])
xlabel("x", 'FontSize', 18)
ylabel("df(x)", 'FontSize', 18)
str = sprintf('First derivative of function f in [%d, %d]', a, b);
title(str, 'FontSize', 15)
set(gca, 'FontSize', 16)
set(gca, 'LineWidth', 1.5)

% Plot ddf
ddf = @(x) -sin(x) .* (1 - x) .^ 2 + 2 * sin(x);
figure
plot(x_plot, ddf(x_plot), 'LineWidth', 2);
hold on
plot(x_plot, zeros(size(x_plot)))
grid on
xlim([a, b])
xlabel("x", 'FontSize', 18)
ylabel("ddf(x)", 'FontSize', 18)
str = sprintf('Second Derivative of function f in [%d, %d]', a, b);
title(str, 'FontSize', 15)
set(gca, 'FontSize', 16)
set(gca, 'LineWidth', 1.5)

%% Use Newton method to find the roots with a tolerance equal to 10−6

tol = 1e-6;
Nmax = 100;
% 1. consider as initial guess x0 = 0.3
% x0=0.3 --> root = 0
x0 = 0.3;

[x1, x1_iter] = newton(f, df, x0, tol, Nmax);
err1 = abs(x1_iter - 0);
% estimate of the convergence order
p = log(err1(3:end) ./ err1(2:end - 1)) ./ log(err1(2:end - 1) ./ err1(1:end - 2));

fprintf("alpha=%d\t  Order=%d\n ", x1(end), p(end));
% pause

figure
plot(p, 'LineWidth', 2);
title('convergence order, root x1=0', 'FontSize', 15);
set(gca, 'FontSize', 16)
set(gca, 'LineWidth', 1.5)
% Simple zero => p = 2

% 2. considering as initial guess x0 = 0.5
% x0=0.5 --> root = 1
x0 = 0.5;
[x2, x2_iter] = newton(f, df, x0, tol, Nmax);
err2 = abs(x2_iter - 1);
% estimate of the convergence order
p = log(err2(3:end) ./ err2(2:end - 1)) ./ log(err2(2:end - 1) ./ err2(1:end - 2));
fprintf("alpha=%d\t Order=%d\n ", x2(end), p(end));
figure
plot(p, 'LineWidth', 2);
title('convergence order, root x2=1', 'FontSize', 15);
set(gca, 'FontSize', 16)
set(gca, 'LineWidth', 1.5)
% Double zero => p = 1

% Errors behaviour
figure
semilogy(err1, 'LineWidth', 2);
hold on
semilogy(err2, 'g', 'LineWidth', 2);
legend('x1=0', 'x2=1');
title('Errors', 'FontSize', 15);
set(gca, 'FontSize', 16)
set(gca, 'LineWidth', 1.5)
% The error for x1 = 0 gets small faster than the error for x2 = 1
% This is due to the different order of convergence of the scheme for x1 e
% x2

% For details on the order of convergence, wait for next lab.
