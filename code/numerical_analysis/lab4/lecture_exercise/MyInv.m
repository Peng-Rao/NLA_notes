function [InvA] = MyInv(A)

    [L, U, P] = lu(A);
    %s = size(A);
    %n = s(1);
    n = length(A);
    InvA=zeros(size(A));
    for k = 1:n
        e = zeros(n,1);
        e(k) = 1;
        y = forward_substitution(L, P*e);
        InvA(:,k) = backward_substitution(U,y);
    end

end