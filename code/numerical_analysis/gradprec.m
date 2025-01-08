function [x, it, res, XK] = gradprec(A,b,P, x0,nmax, toll)

% Preconditioned Gradient Method
%
% INPUT:
%   A: System matrix
%   b: right hand side vector
%   P: preconditioner
%   x0: initial guess
%   alpha: Acceleration Parameter
%   toll: requested tolerance (relative residual)
%   nmax: maximum number of iterations
%
% OUTPUT:
%   x: solution
%   it: number of performed iterations
%   res: vector containing the normalized residual
%   XK: matrix containing at each column the computed solution at k-th
%   iteration

%Check dimensions
n = size(b,1); 
if (size(A,1) ~= size (A,2) || size(A,1) ~= n || size(x0,1) ~= n || size (P,2) ~= n || size(P,1) ~= n )
    error('Dimesioni incompatibili')
end

% Setup
it = 0; 
x = x0; 
r = b - A*x;
resk = norm(r)/norm(b); 
res = resk;
XK=x0;
% Iterative cycle untile the stop criterion is satisfied
while (it < nmax && resk > toll)
    it = it + 1; 
    % Update the preconditioned residual by solving the linear system Pz = r.
    z = P\r;
    % Update alpha
    alpha=(z'*r)/(z'*A*z);
    % Update the solution
    x = x + alpha*z; 
    XK = [XK x];
    % Update the solution
    r = b - A*x;
    resk = norm(r)/norm(b);
    res = [res; resk];
end
