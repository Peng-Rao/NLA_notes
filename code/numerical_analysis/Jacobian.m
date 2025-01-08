clear; clc; close all;

syms x1 x2
F = [x1^2 + x2^2 - 1;
     sin(pi*x1/2) + x2^3];
Jacobian_F = jacobian(F, [x1, x2]);
disp(Jacobian_F)

% change to function handle
F_jacobian = matlabFunction(Jacobian_F, 'Vars', {[x1, x2]});
result = F_jacobian([0.5, 0.5]);
disp(result)