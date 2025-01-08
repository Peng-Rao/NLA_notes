%% Exercise 8.4
clc;clear;close all;
%% 1)
% Consider (x)=sin(x) in the interval [0, pi]: compute the interpolation 
% with n = 1,2,4,8,16,32 elements, find the error in infinity norm 
% and verify it converges quadratically with the distance between two nodes h.
a = 0; b = pi; f = @(x) sin(x);
x_plot = linspace(a, b, 101);

n_vect = [1 2 4 8 16 32];

figure
for i = 1:numel(n_vect)
  n = n_vect(i);
  
  x = linspace(a, b, n+1);
  y = f(x);

  y_plot = interp1(x, y, x_plot);
  
  plot(x_plot, f(x_plot), 'b-', x_plot, y_plot, 'r-', x, y, 'rx', 'LineWidth', 2, 'MarkerSize', 8)
  axis([a-0.2 b+0.2 -0.1+min(f(x_plot)) 0.1+max(f(x_plot))])
  set(gca,'FontSize', 16)
  set(gca,'LineWidth', 1.5)
  
  error(i) = max(abs(f(x_plot) - y_plot));
  pause(1.5)
end

figure
loglog(n_vect, error, 'bx-', 'LineWidth', 2, 'MarkerSize', 8)
hold on, box on
loglog(n_vect, 1./n_vect.^2, 'g-', 'LineWidth', 2)
axis([0.7 100 1e-4 3])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('n','FontSize',16)
ylabel('error','FontSize',16)
legend('error', 'O(h^2)', 'Location', 'ne');

% From the graph we can conclude that the convergence order is 2,
% as predicted by the theory.
p = -diff(log(error)) / log(2);

%% 2)
% Consider now the Runge function
% f(x) = 1/(1+(5x)^2) :
% compute the interpolation with n = 1,2,4,8,16,32 elements,
% find the error in infinity norm and verify it converges quadratically with
% the distance between two nodes h.
clear;
a = -1; b = 1;
f = @(x) 1./(1+25*x.^2); 
x_plot = linspace(a, b, 101);

n_vect = [1 2 4 8 16 32 64 128];

figure
for i = 1:numel(n_vect)
  n = n_vect(i);
  
  x = linspace(a, b, n+1);
  y = f(x);

  y_plot = interp1(x, y, x_plot);
  plot(x_plot, f(x_plot), 'b-', x_plot, y_plot, 'r-', x, y, 'rx', 'LineWidth', 2, 'MarkerSize', 8)
  axis([a-0.2 b+0.2 -0.1+min(f(x_plot)) 0.1+max(f(x_plot))])
  set(gca,'FontSize', 16)
  set(gca,'LineWidth', 1.5)
  
  error(i) = max(abs(f(x_plot) - y_plot));
  pause(1.5)
end

figure
loglog(n_vect, error, 'bx-', 'LineWidth', 2, 'MarkerSize', 8)
hold on, box on
loglog(n_vect, 1./n_vect.^2, 'g-', 'LineWidth', 2)
axis([0.7 600 1e-4 3])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('n','FontSize',16)
ylabel('error','FontSize',16)
legend('error', 'O(h^2)', 'Location', 'ne');

% From the graph we can conclude that the convergence order is 2, as predicted by the theory.

p = -diff(log(error)) / log(2);
%% 3)
figure
for i = 1:numel(n_vect)
  n = n_vect(i)
  
  x = linspace(a, b, n+1);
  y = f(x);

  y_plot = spline(x, y, x_plot);
  plot(x_plot, f(x_plot), 'b-', x_plot, y_plot, 'r-', x, y, 'rx', 'LineWidth', 2, 'MarkerSize', 8)
  axis([a-0.2 b+0.2 -0.1+min(f(x_plot)) 0.1+max(f(x_plot))])
  set(gca,'FontSize', 16)
  set(gca,'LineWidth', 1.5)
  error(i) = max(abs(f(x_plot) - y_plot));
  pause(1.5)
end


