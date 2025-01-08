%% Exercise 8.5
clc; clear; close all;
%% 1)
% Determine how many equally spaced nodes x_i are needed in order
% to get an interpolation error with infinity norm smaller than 10^-3.

f = @(x) exp(x);
% We know that (in particular, C = 1/8)
%	 norm{err, inf}<= h^2/8 norm(f''(x),inf)
%                <= h^2/8 norm(e^x,inf)
%                <= h^2/8 e < \eps = 10^-3
%	thus
h = sqrt( 1e-3 * 8 / exp(1) )

% and the required number of nodes is
n = ceil(2 / h) + 1 % = 38
%% 2)
% Construct the interpolating polynomial using such number
% of nodes, compute the error numerically and check if
% the request is satisfied.
x = linspace(-1, 1, n);
y = exp(x);

x_plot = linspace(-1, 1, 1000);

y_plot = interp1(x,y,x_plot);

figure
plot(x_plot, f(x_plot), 'b-', x_plot, y_plot, 'r-', x, y, 'rx', 'LineWidth', 2, 'MarkerSize', 8)
axis([-1.1 1.1 0 3])
set(gca,'FontSize', 16)
set(gca,'LineWidth', 1.5)

err = max(abs(f(x_plot) - y_plot))

% The requirement is satisfied.

