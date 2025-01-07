%% Exercise 11.1
% Implement the Forward Euler method in a suitable function.

% Determine the step size $h$ needed by the Forward Euler method to
% approximate the solution in $T=1$ with an absolute error 
% smaller than $0.01$. Numerically verify the result.
f    = @(t,y) t - y + 1;
y_ex = @(t) t + exp(-t);
%{	
The following relation is employed:

abs(e)<= ( (M h) / (2 L) ) * exp(L(T-t0)) - 1);
where
h is the stepsize;
L is the Lipschitz constant of f(t, y), which is equal to 1 in our case;
I = [0, T], with T=1 in our case;
M = \max_{[0,T]} \abs{y''(t)}. In our case M = 1.
%}

tol = 0.01;
h = 2*tol/(exp(1) - 1);

t = [0:h:1+h];     % 1 is missing, since 1 si not a multiple of h.
%t = [t, 1];      % Add 1 to the list of nodess


[th, y_fe] = forward_euler(f,  1, 0, t(end), h);

err_fe_time = (abs(y_fe - y_ex(th)));
err_fe=max(err_fe_time);

figure
subplot(1,2,1)
hold on;
fplot(y_ex, [0,1]);
plot(t, y_fe, 'r-');
legend('exact', 'FE');

subplot(1,2,2)
hold on;
plot(t, err_fe_time, 'r-');
legend('FE error');

