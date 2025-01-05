%% Excercise 5.2
clc
clear all
close all

%% Compute Kp (A) for p = 1, 2, ∞ without using MATLAB. Check the results
% in MATLAB for some values of ε (1e − 6, 1e − 8).
% 2-norm
% norm(A,2) = sqrt(eig_max(A'A))
% In this case A is diagonal A'A = A^2
% norm(A,2)=sqrt(eig_max(A^2)) = sqrt((eig_max(A))^2) = eig_max(A) = 1.
% For the same reasons, norm(A^-1,2) = 1/epsilon
% => K2 = norm(A,2) * norm(A^-1,2) = 1/epsilon.

% 1-norm / infinity-norm
% Since A is symmetric, the two norms coincide. In particular:
% norm(A,1) = max_j(sum_i(abs(aij))) = 1
% norm(A^-1,1) = max_j(sum_i(abs(aij^-1))) = 1/epsilon
% K1 = Kinf = 1/epsilon

A = eye(3);
epsilon = 1e-6;
A(3,3) = epsilon;

eingenvalues=eig(A)

K2=cond(A,2)

K1=cond(A,1)

Kinf=cond(A,'inf')


%% For epsilon = 1e−6, and alpha =( 10−12 , 10−6) , consider the perturbation term
% delta_b = [0 0 alpha] , and compute the associated perturbation on the solution x

% deltax = A^-1 deltab = [0 0 alpha/epsilon]'
% c)
% deltax = A^-1 deltab = [alpha 0 0]'

% Both cases verify the inequality: norm(deltax)/norm(x) <= K
% norm(deltab)/norm(b).
% In particular, in the case b) we have an equality
% and in the case c) we have a strict inequality.

b = [1 0 0]';
x_ex = [1 0 0]';

for (alpha = [1e-6 1e-12])
	deltab_1 = [0 0 alpha]';
	max_deltax_inf=Kinf*norm(deltab_1, inf)/norm(b, inf)% K(A)_p ||deltab||_p/||b||_p, p=inf
  deltax = A \ ( deltab_1) % delta x
	norm_deltaxx=norm(deltax, inf) / norm(x_ex, inf) % ||deltax||_p/||x||_p, p=inf

  %check
  % ||deltax||_p/||x||_p<=K(A)_p ||deltab||_p/||b||_p, p=inf
  norm_deltaxx<=max_deltax_inf
end

%% Consider now deltab = [alpha 0 0]' and compute the associated perturbation on the solution x
for (alpha = [1e-6 1e-12])
	deltab_2 = [alpha 0 0]';
	max_deltax_inf2=Kinf*norm(deltab_2, inf)/norm(b, inf)% K(A)_p ||deltab||_p/||b||_p, p=inf
  deltax2 = A \ ( deltab_2) % delta x
	norm_deltaxx2=norm(deltax, inf) / norm(x_ex, inf) % ||deltax||_p/||x||_p, p=inf

  %check
  % ||deltax||_p/||x||_p<=K(A)_p ||deltab||_p/||b||_p, p=inf
  norm_deltaxx2<=max_deltax_inf2
end
