%% Exercise 8.1
clc;clear;close all;
%% 1) 
% Find the interpolation polynomial of minimum order that interpolates such points
% using Lagrange polynomials as basis functions.

x = [0 1 3 4]';
y = [5 3 5 12]';


% Since we have 4 points the interpolant polynomial of minimum order is of 4-1 = third order.
% Store the coefficients of the Lagrange polynomials in a matrix.
lagr_poly=zeros(numel(x), numel(x));
for j = 1:numel(x)
	% set difference: nodes now contains all the nodes except x(i).
	nodes = setdiff(x, x(j));
	% poly(r) returns the coefficients (in a vector) of the polynomial
    % whose root are the elements of r.
	% poyval(coefficients, hat_x) evaluates the polynomial with 
    % given coefficients at the point hat_x.
	lagr_poly(:, j) = poly(nodes) / polyval(poly(nodes), x(j));
	% each column contains the coefficients of the j-th 
	% basis function
end

%% 2)
% Plot the values attained by the obtained polynomial on a finer grid of nodes and verify that the
% the polynomial actually interpolates the points.
xx = linspace(-0.5, 4.5, 1000);

% Display the basis functions


for i = 1:numel(x)
  name=sprintf("phi_%g",i);
  figure()
  hold on, box on
  axis([-1 5 -1.5 2.2])
  plot(xx, polyval(lagr_poly(:, i), xx), 'b-', 'LineWidth', 2)  
  plot(x, polyval(lagr_poly(:,i), x), 'ro', 'LineWidth', 2, 'MarkerSize', 10)
  set(gca,'FontSize',16)
  set(gca,'LineWidth',1.5)  
  xlabel('x','FontSize',16)
  ylabel('p_3(x)','FontSize',16)
  title(name)

end

% Sum the coefficients of the basis element with the weigths:
coeff = lagr_poly * y;
yy = polyval(coeff, xx);
%
figure
hold on, box on
plot(x, y, 'ro', 'LineWidth', 2, 'MarkerSize', 10)
plot(xx, yy, 'b-', 'LineWidth', 2)
axis([-1 5 0 20])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('x','FontSize',16)
ylabel('p_3(x)','FontSize',16)
title("Lagrange Interpolating Polynomial")


%% 3)
% Repeat the operation using MATLAB command polyfit
coeff2 = polyfit(x, y, 3)
[coeff, coeff2']
