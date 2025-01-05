function [x, it, res] = richprec(A, b, P, alpha, x0, nmax, toll)
    % Preconditioned Stationary Richardson Method
    %
    % Input parameters:
    %   A: system matrix
    %   b: right-hand side vector
    %   P: preconditioner
    %   x0: initial guess vector
    %   alpha: Richardson coefficient
    %   toll: tolerance on the normalized residual
    %   nmax: maximum number of iterations
    %
    % Output parameters:
    %   x: obtained solution
    %   it: number of iterations performed
    %   res: vector containing the normalized residuals

    % Check that matrices A and P are square and that, together with the initial guess
    % x0, they have dimensions compatible with b.
    n = size(b, 1); 
    if (size(A, 1) ~= size(A, 2) || size(A, 1) ~= n || size(x0, 1) ~= n || size(P, 2) ~= n || size(P, 1) ~= n)
        error('Incompatible dimensions')
    end

    % Initialize x with x0, compute the residual and the normalized residual
    it = 0; 
    x = x0; 
    r = b - A * x;
    resk = norm(r) / norm(b); 
    res = resk;

    % Iterative loop until stopping criterion is met
    while (it < nmax && resk > toll)
        it = it + 1; 
        % Update the preconditioned residual by solving the linear system
        % Pz = r. For simplicity, use the backslash operator \
        z = P \ r;
        % Update the solution
        x = x + alpha * z; 
        % Update the residual and the normalized residual
        r = b - A * x;
        resk = norm(r) / norm(b);
        res = [res; resk];
    end
end