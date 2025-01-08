%% Exercise 8.2
clc; clear; close all;
%% 1)
% Consider a set of equally spaced nodes $x_i$ and find the interpolating 
% polynomial using Lagrange basis polynomials.
% Since the polynomial has degree 9 we need 10 nodes.
f = @(x) sin(x);
x = linspace(0, pi, 10)';
y = f(x);
lagr_poly=zeros(numel(x), numel(x));
for i = 1:numel(x)
  nodes = setdiff(x, x(i));
  lagr_poly(:,i) = poly(nodes) / polyval(poly(nodes), x(i));
end
% Sum the coefficients of the basis element with the weigths
coeff = lagr_poly * y;

%% 2)
% Find again the polynomial using polyfit command.

% polyfit
coeff2 = polyfit(x, y, 9);
% Check
[coeff, coeff2']

%% 3)
% Estimate the interpolation error using the related theorem.
% Then evaluate the interpolation polynomial in 1000 equally spaced points
% in the interval and plot the interpolation error. Motivate the result.
% We have to apply the formula
% e_k(x)<= K_{k+1} h^{k+1}}/(4(k+1)),
% where the bound $K_{k+1}$ on the absolute value of the $k+1 = 10$-th 
% derivative is trivially obtained as $K_{k+1} = 1$. Thus ...
h=x(2)-x(1);

err_est = 1*(h)^10 / (4*10);
fprintf("Estimated Error: %d", err_est);
% Plot the obtained polynomial
xx = linspace(0, pi, 1000);
yy = f(xx);
pp = polyval(coeff, xx);

figure
% Just check that the polynomial interpolates the data-points
subplot(2,1,1)
plot(xx, yy, 'r-', 'LineWidth',2)
hold on, box on
plot(x, y, 'rx', 'LineWidth',2, 'MarkerSize',10)
axis([-0.1 pi+0.1 -0.1 1.1])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('x','FontSize',16)
ylabel('p(x)','FontSize',16)
title("Lagrange Interpolating Polynomial")

err = abs(pp - yy);

subplot(2,1,2)
plot(xx, err, 'r-', 'LineWidth',2)
hold on, box on
plot(x, 0*x, 'rx', 'LineWidth',2, 'MarkerSize',10)
plot(x, err_est + 0*x, 'k--', 'LineWidth',2)
axis([-0.1 pi+0.1 -0.5e-7 7.5e-7])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('x','FontSize',16)
ylabel('|e(x)|','FontSize',16)

% The interpolation on equally spaced nodes produces a non uniform error in the interval,
% which grows towards the extreme points.
%% 4)
% Repeat the operations with polynomials of order k =1,...,30.
% Plot the behaviour of abs(e_k(x)) as a function of k and 
% comment the results.
degree=30;
errk=zeros(degree);
for k = 1:degree
  x = linspace(0, pi, k+1)';
  y = f(x);
  p = polyfit(x, y, k);
  
  xx = linspace(0, pi, 1000);
  yy = f(xx);
  pp = polyval(p, xx);
  errk(k) = max(abs(pp - yy));       % Take the maximum error
end

% Plot
figure("Name","Error as function of k")
semilogy(errk, 'b', 'LineWidth',2)
hold on, box on
axis([0 31 1e-14 5])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('x','FontSize',16)
ylabel('max|e(x)|','FontSize',16)

% The error exponentially decreases with the number of nodes until k = 17. 
% After that value of k the error increases. 
% The warnings print out by MATLAB suggest that this is because the nodes 
% become too close and the problem is ill-conditioned.

