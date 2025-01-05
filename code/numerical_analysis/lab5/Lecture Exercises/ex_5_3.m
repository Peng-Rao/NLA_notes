%% Homework 5.1
clc
clear all
close all

% We can invert the relation
% norm(deltax)/norm(x) <= norm(deltab)/norm(b)
% to get an estimate for Kp(A):
% Kp(A) >= norm(deltax)/norm(x) * norm(b)/norm(deltab)

for (n = [10 20 40])
	pert_mag = 1e-6; % Perturbation magnitude
	n_trials = 100;
	H = hilb(n);
	x = ones(n, 1);
	b = H*x;
	KH_est = 0;
	for (ii = 1:n_trials)

	  deltab = randn(n, 1) ;
	  deltab= deltab/norm(deltab) * pert_mag;;
     warning('off', 'all')
	  deltax = H \ deltab;
	  KH_est_ii = norm(deltax)/norm(x) * norm(b)/norm(deltab);
	  KH_est = max(KH_est_ii, KH_est);
	end
	KH_est
end

cond( hilb(10) )
cond( hilb(20) )
cond( hilb(40) )

% The estimates obtained with the perturbing technique are lower. This is expected, since
% the condition number represents the maximum
% possible amplification of the relative error on data. With the first
% approach we might not have considered the worst condition,
% hence the estimate is lower than the result with cond command.

n = [1:20];

for (ii = n)
  H = hilb(ii);
  x_ex = ones(ii, 1);
  b = H*x_ex;
  x = H\b;
  KH(ii) = cond(H);
  err(ii) = norm(x - x_ex) / norm(x);
end

figure
semilogy(n, KH, 'xb-', 'LineWidth',2, 'MarkerSize',8)
hold on
semilogy(n, err, 'xr-', 'LineWidth',2, 'MarkerSize',8)
semilogy(n, ones(n(end),1), 'k--', 'LineWidth',2, 'MarkerSize',8)
set(gca, 'FontSize',16)
set(gca, 'LineWidth', 1.5)
axis([0 n(end)+1 1e-17 1e20])
xlabel('n')
ylabel('K_2(H_n) and err')
legend('K_2(H_n)', 'relative error', 'Location','SouthEast')


% For n > 12 the relative error is 1. This means that the solution is completely meaningless.
