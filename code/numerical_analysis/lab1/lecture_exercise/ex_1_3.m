function Mk = ex_1_3(k)

    % Create a diagonal matrix with the right elements and dimension
    Mk = diag(2 .^ (1 ./ [1:2 * (k + 1)]));
    % The bottom right element will be overwritten

    % Last column
    Mk(2:2:end, end) = ex_1_2(k);

    % Last line
    Mk(end, 1:2:end) = ex_1_2(k);
    Mk(end, 2:2:end) = ex_1_2(k);

end
