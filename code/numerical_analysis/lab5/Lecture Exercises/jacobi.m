function [x,k]=jacobi(A,b,x0,toll,nmax)

% Jacobi Method
%
% A: matrix of the system
% b: known term
% x0: initial guess
% tol: tolerance on the normalized residual
% nmax: maximum number of iterations
%
% x: obtained solution
% k: number of performed iterations
n = size(b,1);

% Check the A is square and that its dimensions are compatible
% with the initial guess x0 and the known term
if ((size(A,1) ~= n) || (size(A,2) ~= n) || (size(x0,1) ~= n))
  error('Dimensioni incompatibili')
end

% Check that the matrix does not have null diagonal elements
if (prod(diag(A)) == 0)
  error('res_normore: elementi diagonali nulli')
end

%Build the iteration matrix Bj and g
D = diag(diag(A));
Bj = eye(n) - D\A;
g = D\b;

%Initialize x and compute the normalized residual
x = x0;
r = b - A*x;
res_norm = norm(r) / norm(b);

%Initialize the iteration index
k = 0;

while (res_norm > toll && k < nmax)
    k = k + 1;

    %Update x
    x=Bj*x+g;

    %Compute residual and error
    r = b - A*x;
    res_norm = norm(r)/norm(b);
end



