function [x] = backward_substitution(A, b)
    % BACKWARD_SUBSTITUTION Solving the upper triangular system using backward
    % substitution method.
    %   x = backward_substitution(A, b)
    %
    %   Inputs  : A = system coefficient matrix (upper triangular)
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
    
    % Ensure A is upper triangular
    if ~istriu(A)
        error('Matrix A must be upper triangular.');
    end
    
    % Initialize solution vector
    x = zeros(n, 1);
    
    % Backward substitution algorithm
    for i = n:-1:1
        if A(i, i) == 0
            error('Matrix A has a zero diagonal element, system is singular.');
        end
        
        if i == n
            % Special case for the last element
            x(i) = b(i) / A(i, i);
        else
            % General case for other elements
            x(i) = (b(i) - A(i, i+1:n) * x(i+1:n)) / A(i, i);
        end
    end
end