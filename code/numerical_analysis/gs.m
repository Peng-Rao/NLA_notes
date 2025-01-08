function [x,k]=gs(A,b,x0,tol,nmax)

% Gauss-Seidel method
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
if (( size(A,1)~=n) || (size(A,2)~=n) || (size(x0,1) ~= n) )
  error('dimensioni incompatibili')
end

% Check that the matrix does not have null diagonal elements
if (prod(diag(A)) == 0)
    error('errore: elementi diagonali nulli')
end

%Build the iteration matrix Bgs and g
D=diag(diag(A));
E=-tril(A,-1);
F=-triu(A,1);
Bgs=(D-E)\F;
g=(D-E)\b;

%Initialize x and compute the normalized residual
x = x0;
r = b - A * x;
err = norm(r) / norm(b);

%Initialize the iteration index
k = 0;

while ( err > toll && k < nmax )
  k = k + 1;

  %Update x
  x=Bgs*x+g;

  %Compute residual and error
  r = b - A*x;
  err = norm(r)/norm(b);
end

