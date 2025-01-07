clear; clc; close all;
%% define function f and initial data
f = @(t,y) -(t+1) ./ (t+2) .* y;
y_es = @(t) (t + 2) .* exp(-t);
h = 0.5;
t_0 = 0;
y_0 = 2;
T = 5;

%% approximate problem 1 using the Crank Nicolson method with step size h= 0.5.
[t, y, iter] = crank_nicolson(f, y_0, t_0, T, h);
y(2)
iter(2)
y(6)
iter(6)

%% Use Matlab to graphically represent the exact solution
tvec=linspace(t_0, T, 1000);
figure
plot(t, y, '--')
hold on
plot(tvec, y_es(tvec))
legend("h=0.5", "exact")
name="numVSex";
% print(gcf, name, '-dpng');

%% Use the Crank Nicolson method to solve the problem with step size h=[1, 0.5, 0.25, 0.125]
hvec = [1, 0.5, 0.25, 0.125]; 
err = [];
for h = hvec
    [t, y, iter] = crank_nicolson(f, y_0, t_0, T, h);
    err = [err max(abs(y - y_es(t)))];
end

%% Use the obtained results to estimate the converge orfer of the method with respect to h.
p = log(err(1 : end-1) ./ err(2 : end)) / log(2);
% The Crank Nicolson Method shows second order convergence as predicted by the theory.
figure
loglog(hvec, err)
hold on
loglog(hvec, hvec .^ 2)
legend("err", "O(h^2)", 'Location','south')