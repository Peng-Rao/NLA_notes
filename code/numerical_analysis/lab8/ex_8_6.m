%% Exercise 8.6
clc; clear; close all
%% 1)
% Setting the function and its visualization
a = -1; b = 1;
f = @(x) abs(x - pi/12); 

xx = linspace(a, b, 1000);
fxx = f(xx);

figure("Name","Runge's phenomenon")
% matrix of plots: one row, two columns, first subplot
hold on, box on
plot(xx, fxx, 'b-', 'LineWidth',2)
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('x','FontSize',16)
ylabel('f(x)','FontSize',16)

% a) The interpolating polynomials Π n f (x ) using equally
% spaced nodes show the Runge’s phenomenon

for k = 2:2:16
  x = linspace(a, b, k+1);
  fx = f(x);
  coef = polyfit(x, fx, k);
  yy = polyval(coef, xx);
  plot(xx, yy, 'r-', 'LineWidth',1)
  axis([a-0.2 b+0.2 -0.1+min(f(xx)) 0.1+max(f(xx))])
  pause(1.5)
end

% The interpolation polynomials approach the function in the middle of the 
% interval, but close to the boundaries increasing oscillations appears.

%% 2)
% Computation of the piecewise linear interpolation (interp1 command)
% and calculation of the convergence order ( f(x) is not C2(I) function!!)

% clear all
a = -1; b = 1;
f = @(x) abs(x - pi/12); 
x_plot = linspace(a, b, 1000);

% Number of subintervals: 2^k
% n_vect = [1 2 4 8 16 32];
n_vect = [1 2 4 8 16 32 64 128 256];

figure
for i = 1:numel(n_vect)
  n = n_vect(i)
  x = linspace(a, b, n+1);
  y = f(x);
  y_plot = interp1(x, y, x_plot);
  plot(x_plot, f(x_plot), 'k-', x_plot, y_plot, 'r-', x, y, 'ro', 'LineWidth', 2, 'MarkerSize', 8)
  axis([a-0.2 b+0.2 -0.1+min(f(x_plot)) 0.1+max(f(x_plot))])
  set(gca,'FontSize', 16)
  set(gca,'LineWidth', 1.5)
  
  %error(i) = max(abs(f(x_plot) - y_plot));
  error(i) = norm((f(x_plot) - y_plot),'inf');
  %pause
end

% determination of the element width
H = (b-a)./n_vect;

% Are 32 subintervals enought to grafically assess 
% the convergence order?

figure
% the dash after the color and the markersize denotes
% points linked by lines
loglog(H, error, 'b*-', 'LineWidth', 2, 'MarkerSize', 8)
hold on, box on 
% linear order
loglog(H, H, 'k-', 'LineWidth', 2)
hold on, box on
% quadratic order
loglog(H, H.^2, 'r-', 'LineWidth', 2)
%axis([0.7 600 1e-4 3])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('step size: h=(b-a)/n','FontSize',16)
ylabel('error','FontSize',16)
legend('error', 'O(h)', 'O(h^2)', 'Location', 'ne');

% A second order convergence cannot be expected, since the function is not smooth enough.
% Calculation of the convergence order
p = -diff(log(error)) / log(2)

%% c) Interpolate the function using a piecewise cubic spline (spline
% command) with n = 1, 2, 4, 8, 16, 32 elements.
n_vect = [1 2 4 8 16 32];
figure
for (i = 1:numel(n_vect))
  n = n_vect(i)
  x = linspace(a, b, n+1);
  y = f(x);
  y_plot = spline(x, y, x_plot);
  plot(x_plot, f(x_plot), 'b-', x_plot, y_plot, 'r-', x, y, 'ro', 'LineWidth', 2, 'MarkerSize', 8)
  axis([a-0.2 b+0.2 -0.1+min(f(x_plot)) 0.1+max(f(x_plot))])
  set(gca,'FontSize', 16)
  set(gca,'LineWidth', 1.5)
  pause(1.5)
end

%% d) EXTRA- Interpolation of the points generated with the above function with nodes n = 10
% and using the least square approach with varying the degree of the interpolant.

% close all
%{
a = -1; b = 1;
f = @(x) abs(x - pi/12); 
x_plot = linspace(a, b, 1000);
x_nodes = linspace(a, b, 10);
y_nodes = f(x_nodes);

figure
plot(x_nodes, y_nodes, 'rO');
hold on;

for ii = 4:8
    v = polyfit(x_nodes, y_nodes, ii);
    y_plot = polyval(v, x_plot);
    plot(x_plot, y_plot)
    pause(2)
end

figure
plot(x_nodes, y_nodes, 'rO');
hold on;
v = polyfit(x_nodes, y_nodes, 9);
y_plot = polyval(v, x_plot);
plot(x_plot, y_plot)
%}