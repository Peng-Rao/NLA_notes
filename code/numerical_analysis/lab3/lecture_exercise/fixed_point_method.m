function [x, x_iter] = fixed_point_method(f, x0, tol, max_iter)
    % FIXED_POINT_METHOD Find a root of the equation f(x) = 0 using the fixed point iteration method.
    %
    %   [x, x_iter] = fixed_point_method(f, x0, tol, max_iter)
    %
    %   Inputs:
    %       f         = function handle to g(x), such that x = g(x)
    %       x0        = initial guess
    %       tol       = requested tolerance
    %       max_iter  = maximum number of iterations
    %
    %   Outputs:
    %       x         = approximation of the root
    %       x_iter    = vector of the approximations of the root at each step

    % Initialize variables
    x_iter = x0; % Vector to store all approximations
    x = x0; % Current approximation
    iter = 0; % Iteration counter

    % Fixed-point iteration loop
    while iter < max_iter
        iter = iter + 1;

        % Compute next approximation
        x_next = f(x);
        x_iter = [x_iter, x_next]; % Store current approximation

        % Check for convergence
        if abs(x_next - x) < tol
            fprintf('Converged after %d iterations.\n', iter);
            x = x_next;
            return;
        end

        % Update x for the next iteration
        x = x_next;
    end

    % If we exit the loop without meeting tolerance
    warning('Method did not converge within the maximum number of iterations.');
end
