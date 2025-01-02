% EXERCISE 2.1
%% closes all figures whose handles are visible
close all
clear all
clc


%% PLOT THE FUNCTION 
f= @(x) x.^3-(2 + exp(1))*x.^2 + (2*exp(1) + 1)*x + (1 - exp(1)) - cosh(x - 1);
%f= @(x) x.^3-(2 + exp(1))*x.^2 + (2*exp(1) + 2)*x + (1 - exp(1)) - sinh(x - 1);

a=0.5; b=5.5;
x_plot=linspace(a,b,1000);
figure
plot(x_plot,f(x_plot),'LineWidth', 2);
% add a grid to the plot
grid on
hold on
plot(x_plot, zeros(size(x_plot)),'LineWidth', 2)
xlim([a, b])
xlabel("x",'FontSize', 18)
ylabel("f(x)",'FontSize', 18)
str=sprintf('Function f in [%d, %d]', a, b);
title(str, 'FontSize', 15)
set(gca,'FontSize', 16)
set(gca,'LineWidth', 1.5)
% pause the execution
% pause

% from the plot two different roots can be identified. The bisection method,
% nevertheless, can be applied only to the root on the right: the one
% belonging to the interval [3,5]. Actually, in the other case, there isn't
% any interval such that the first derivative has constant sign and the
% root belongs to this interval. Therefore the Bolzano theorem hypothesis
% are not respected in this case.

%%
% FIND THE ROOT (BISECTION METHOD)
% The interval is [3,5]
a=3;
b=5;
tol=1.e-3;

[x,x_iter]=bisection(f,a,b,tol);
%bisection_plot(f, a, b, tol)
str=fprintf("The root in the interval [%d, %d] is x=%f. \n", a, b, x);

%%
% PLOT THE ITERATIONS OF THE FUNCTION

x_plot=linspace(a,b,1000);
figure
plot(x_plot,f(x_plot), 'LineWidth', 2);
str=sprintf("Iterations required to reach the tollerance: %f", length(x_iter));
title(str,'FontSize', 15)
grid on
hold on
%disp('Press any key...');
for ii=1:length(x_iter)
    plot(x_iter(ii),f(x_iter(ii)),'r*')
    xlabel("x",'FontSize', 18)
    ylabel("f(x)",'FontSize', 18)
    pause(3)
end

%% PLOT THE ERROR
figure

for ii=1:length(x_iter)
    plot((ii),abs(x_iter(ii)-x),'r*')
    drawnow
    hold on
    xlabel("iter",'FontSize', 18)
    ylabel("err",'FontSize', 18)
    pause(2)
end

