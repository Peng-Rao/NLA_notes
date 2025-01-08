%% Exercise 9.5
clear all; close all

n = 15;
x = sort (rand (n, 1));
y = 2 + 3*x + randn(n, 1)/10;

figure (1)
plot (x, y, 'x')
hold all

p = polyfit (x, y, 1);

D    = (n) * sum (x.^2) - sum (x) ^2;

% a is the same as p
a(1) = 1/D * ((n) * sum (x .* y) - sum (x) * sum(y));
a(2) = 1/D * (sum (x.^2) * sum (y) - sum (x) * sum (x .* y));

plot (x, a(1)*x + a(2))
plot(x, polyval(p, x))
legend ("Data", "Self-Computation", "with polyfit",'Location','southeast')
%% compute mean square error
eta = sum ((a(1)*x + a(2) - y).^2)/n

figure (2)
da = (- a(1)/2) : a(1)/10 : (+ a(1)/2);
aa = a(1) + da;
ii = 1;
for a1_a = aa
  eta_a(ii) = sum ((a1_a*x + a(2) - y).^2)/n;
  ii = ii+1;
end

plot (aa, eta_a, a(1), eta, 'x')

figure (3)
da = (- a(2)/2) : a(2)/10 : (+ a(2)/2);
aa = a(2) + da;
ii = 1;
for a2_a = aa
  eta_a(ii) = sum ((a(1)*x + a2_a - y).^2)/n;
  ii = ii+1;
end

plot (aa, eta_a, a(2), eta, 'x', 'MarkerSize',15, 'LineWidth',3)