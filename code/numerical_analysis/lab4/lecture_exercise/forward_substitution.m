function [x] = forward_substitution(A, b)
    % FORWARD_SUBSITUATION Solving the lower triangular system using forward
    % substitution method.
    %   x = forward_substitution(A,b)
    %
    %   Inputs  : A = system coefficient matrix (lower triangular)
    %             b = right-hand side vector
    %   Outputs : x = solution vector

    % Validate inputs
    [m, n] = size(A);

    if m ~= n
        error('Matrix A must be square.');
    end

    if length(b) ~= n
        error('Vector b must have the same number of rows as A.');
    end

    % Ensure A is lower triangular
    if ~istril(A)
        error('Matrix A must be lower triangular.');
    end

    % Initialize solution vector
    x = zeros(n, 1);

    % Forward substitution algorithm
    for i = 1:n
        if A(i, i) == 0
            error('Matrix A has a zero diagonal element, system is singular.');
        end
        
        if i == 1
            % Special case for the first element
            x(i) = b(i) / A(i, i);
        else
            % General case for subsequent elements
            x(i) = (b(i) - A(i, 1:i-1) * x(1:i-1)) / A(i, i);
        end
    end

end
