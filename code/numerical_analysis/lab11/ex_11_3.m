clear; clc; close all;
%% define function f and initial data
f = @(t,y) -1./t.*(2*y+t.^2.*y.^2);
y_es = @(t) 1 ./ (t .^2 .* (1 + log(t)));
h1 = 0.2;
t_0 = 1;
y_0 = 1;
T = 5;

%% solve point a
[t_a, u_a] = forward_euler(f, y_0, t_0, T, h1);

%% solve point b
h2 = 0.1;
[t_b, u_b] = forward_euler(f, y_0, t_0, T, h2);
time_vec=linspace(t_0, T, 1000);

%% plot
figure
plot(t_a, u_a, '-ro')
hold on
plot(t_b, u_b, '-b^')
plot(time_vec, y_es(time_vec), 'g')
legend("h=0.2", "h=0.1", "Exact")
% name=sprintf("comparison");
% print(gcf,"comparison", '-dpng');
% comment: The numerical solution is more accurate the lower the steplenght.

%% compute h = [0.1, 0.050 .0250.0125]
err = [];
for h = [0.1, 0.05 0.0250 0.0125]
    T = 4 / h;
    [tt, U] = forward_euler(f, y_0, t_0, T, h);
    err = [err max(abs(y_es(tt) - U))];   
end

%% Report the error in a loglog plot.
figure
loglog([0.1, 0.05 0.0250 0.0125], err,'-o')
hold on
loglog([0.1, 0.05 0.0250 0.0125], [0.1, 0.05 0.0250 0.0125],'--')
grid on
legend("numerical err", "estimate", 'Location','best')
print(gcf, "error", '-dpng')
% comment: The error decreases linearly with h, in accordance with the theoretical
% results. The forward Euler method is, indeed, first order method.