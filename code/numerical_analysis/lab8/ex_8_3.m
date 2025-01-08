%% Exercise 8.4
clc;clear;close all;
%% 1)
% Verify that the interpolation polynomials p_k(x) using equally spaced 
% nodes are such that
% lim_{k->infinity} abs( f(x) - p_k(x)) ~ 0

f = @(x) 1./(1 + (5*x).^2); 

xx = linspace(-1, 1, 1000);
fxx = f(xx);

figure("Name","Equally spaced nodes")
%subplot(1,2,1)
hold on, box on
plot(xx, fxx, 'b-', 'LineWidth',2)
axis([-1.1 1.1 -0.4 1.2])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('x','FontSize',16)
ylabel('f(x)','FontSize',16)

for k = 2:2:16
  x = linspace(-1, 1, k+1);
  fx = f(x);
  coef = polyfit(x, fx, k);
  yy = polyval(coef, xx);
  plot(xx, yy, 'r-', 'LineWidth',2)
  pause(1)
end

%subplot(1,2,2)
%hold on, box on
%plot(xx, fxx, 'b-', 'LineWidth',2)
%axis([-1.1 1.1 -1.2 2.4])
%set(gca,'FontSize',16)
%set(gca,'LineWidth',1.5)
%xlabel('x','FontSize',16)
%ylabel('f(x)','FontSize',16)

%for k = 12:2:16
 % x = linspace(-1, 1, k);
  %fx = f(x);
  %coef = polyfit(x, fx, k-1);    
  %yy = polyval(coef, xx);
  %plot(xx, yy, 'r-', 'LineWidth',2)
  %pause(1)
%end

% The interpolation polynomials approach the function in the middle 
% of the interval, but close to the boundaries increasing oscillations appears.


%% 2)
% Overcome this problem using non uniformly distributed nodes, e.g. Chebyshev nodes
figure("Name","Chebyshev nodes")
%subplot(1,2,1)
hold on, box on
plot(xx, fxx, 'b-', 'LineWidth',2)
axis([-1.1 1.1 -0.1 1.1])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('x','FontSize',16)
ylabel('f(x)','FontSize',16)

for k = 2:2:20
  j = [0:k-1];
  xcheb = cos((2*j+1)/(2*(k))*pi);
  fcheb = f(xcheb);
  coef = polyfit(xcheb, fcheb, k-1);    
  yy = polyval(coef, xx);
  plot(xx, yy, 'r-', 'LineWidth',2)
  pause(1)
end

%subplot(1,2,2)
%hold on, box on
%plot(xx, fxx, 'b-', 'LineWidth',2)
%axis([-1.1 1.1 -0.1 1.1])
%set(gca,'FontSize',16)
%set(gca,'LineWidth',1.5)
%xlabel('x','FontSize',16)
%ylabel('f(x)','FontSize',16)

%for k = [12:2:20]
%  j = [0:k-1];
%  xcheb = cos((2*j+1)/(2*(k))*pi);
%  fcheb = f(xcheb);
%  coef = polyfit(xcheb, fcheb, k-1);    
%  yy = polyval(coef, xx);
%  plot(xx, yy, 'r-', 'LineWidth',2)
%  pause(1)
%end

% The oscillating behavior is eliminated with Chebyshev nodes: 
% the usage of this kind of nodes allow for a better distribution of the error,
% more uniformly in the interpolation interval. This is clear if we plot the 
% monic polynomial, as an example for the case of 10 nodes.

%%
k = 10;
j = [0:k-1];
xeven = linspace(-1, 1, k);
xcheb = cos((2*j+1)/(2*k)*pi);

coef_even = poly(xeven);
coef_cheb = poly(xcheb);

pi_even = polyval(coef_even, xx);
pi_cheb = polyval(coef_cheb, xx);

figure
plot(xx, pi_even, 'r', 'LineWidth',2)
hold on, box on
plot(xeven, 0*xeven, 'rx', 'LineWidth',2, 'Markersize',10)
plot(xx, pi_cheb, 'b', 'LineWidth',2)
plot(xcheb, 0*xcheb, 'bx', 'LineWidth',2, 'Markersize',10)
axis([-1.1 1.1 -13e-3 3e-3])
set(gca,'FontSize',16)
set(gca,'LineWidth',1.5)
xlabel('x','FontSize',16)
ylabel('pi(x)','FontSize',16)

% The monic polynomial obtained with equally spaced nodes shows high peaks
% next to the extremes of the interval. Instead the one related to the
% Chebyshev nodes has a series of maxs and mins of the same height.

