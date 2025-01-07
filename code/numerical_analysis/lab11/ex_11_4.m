clear; clc; close all

%% define function f and initial data
f = @(t, y) exp(-t) .* sin(y);

y_0 = pi / 2;
t_0 = 0;
T = 10;

%% backward euler.m with h= 0.1 and h= 1
h_1 = 0.1;
h_2 = 1;

tic
[t_a, u_a] = backward_euler(f, y_0, t_0, T, h_1);
toc

tic
[t_b, u_b] = backward_euler(f, y_0, t_0, T, h_2);


%% the plot of the solutions obtained in point a
time_vec = linspace(t_0, T, 1000);
figure
plot(t_a, u_a, '-ro')
hold on
plot(t_b, u_b, '-b^')
legend("h=0.1", "h=1")

% comment: Regarding stability, it is observed that both numerical solutions are free
% from oscillations and are therefore stable. 
% This aligns with the theory, which states that the backward Euler method 
% is unconditionally absolutely stable.
%
% As for accuracy, we note significant differences between the two solutions. 
% This is consistent with the fact that the solution for "large" values of h 
% is not very accurate (although it is stable), and only with a "small" value 
% of h is an accurate solution achieved.
%
% Regarding computational time, we can measure the time elapsed in both cases.
% We can conclude that for increasing h, the total computational time decreases 
% (at the expense, as mentioned, of accuracy).

%% Solve the same problem of point a with the forward Euler method and
h = 2;
[t, y] = forward_euler(f, y_0, t_0, T, h);
y(2)

% comment: The required value is obtained using the command y(2), as the first component 
% of the vector contains the initial data for t = 0, and thus the second 
% component contains the approximation for t = h = 2. 
% The result is y(2) = 3.5708. Observing the behavior of the numerical solution, 
% an oscillatory trend is evident, with y(2) being a maximum. This is 
% 0consistent with the theory, which states that the forward Euler method is 
% conditionally absolutely stable, specifically requiring 
% h < 2/\lambda, where lambda is a value that depends on the function f.