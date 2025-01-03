%% Excercise 4.1

% Write a function which implements the backward substitution
% method for solving a generic upper triangular system. Apply
% such a function to solve the linear system Ax = b with

%A = [1 2 3 4;
%     0 1 2 3;
%     0 0 1 2;
%     0 0 0 1];
%b = [1 1 1 1]'

A = diag(ones(4, 1)) + 2 * diag(ones(3, 1), 1) + 3 * diag(ones(2, 1), 2);
A(1, end) = 4;

b = ones(4, 1);

x_bwd = backward_substitution(A, b)

% Check with builtin \ operator of MATLAB
x_mat = A \ b

% Write a function which implements the backward substitution
% method for solving a generic upper triangular system. Apply
% such a function to solve the linear system A'x = b with

x_fwd = forward_substitution(A', b)

% Check with builtin \ operator of MATLAB
x_mat2 = A' \ b

% Use the backward and the forward algorithms to solve the
% system A
y = forward_substitution(A', b);
x = backward_substitution(A, y)

% Check with builtin \ operator of MATLAB
(A' * A) \ b
