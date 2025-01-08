function [x, it, res] = richardson(A, b, x0, alpha, toll, nmax)
    % Stationary Richardson Method
    %
    % Parameters:
    %   A: system matrix
    %   b: right-hand side vector
    %   x0: initial guess vector
    %   alpha: Richardson coefficient
    %   toll: tolerance on the normalized residual
    %   nmax: maximum number of iterations
    %
    % Outputs:
    %   x: obtained solution
    %   it: number of iterations performed
    %   res: vector containing the normalized residuals

    n = size(b, 1);

    % Check that matrix A is square and that, together with the initial guess
    % x0, it has dimensions compatible with b.
    if ((size(A, 1) ~= n) || (size(A, 2) ~= n) || (size(x0, 1) ~= n))
        error('Incompatible dimensions')
    end

    % Initialize x as x0, compute the residual and the normalized residual
    x = x0;
    r = b - A * x;
    resk = norm(r) / norm(b); 
    res = resk;

    % Initialize the iteration index
    it = 0;

    while (resk > toll && it < nmax)
        it = it + 1;
        % Compute the new x according to the Richardson method
        x = x + alpha * r;
        % Compute the residual and the normalized residual
        r = b - A * x;
        resk = norm(r) / norm(b);
        % Add the normalized residual to the vector of normalized residuals
        res = [res; resk];
    end
end