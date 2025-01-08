function [x,res,niter,difv,x_vect] = newtonsys(Ffun,Jfun,x0,tol, kmax,normtype,varargin)
%  [x,res, niter, difv]=newton_sys(Ffun,Jfun,x0,tol,kmax,normtype)
%
%  Newton's method
%  for the system of equations f(x)=0;
%
%  Input parameters:
%
%  Ffun       Function handle to vector function f(x)
%  Jfun       Jacobian handle matrix
%  x0         Initial value for iterative process
%  nmax       Maximum number of allowed iterations
%  tol        Absolute error tolerance
%  normtype   Type of norm used in the error estimation
%             1   l_infinity norm
%             2   l_2 norm

%  varargin,  is an input variable in a function definition statement that
%             enables the function to accept any number of input arguments.
%             Specify varargin by using lowercase characters.
%             After any explicitly declared inputs, include varargin as the last input argument .
%             When the function executes, varargin is a 1-by-N cell array, where N is
%             the number of inputs that the function receives after the explicitly
%             declared inputs. If the function receives no inputs after the explicitly
%             declared inputs, then varargin is an empty cell array.

%
%  Output parameters:
%
%  x          Vector containing the approximate
%             solution computed by the method at
%             the last iteration performed
%  res        The residual evaluated in x
%  niter      Number of iterations performed
%  difv       Contains ||x^(k+1)-x^(k)||
%  x_vect     Matrix containing in the column k-th the
%             approximate solution at iteration k
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 0;
x_vect = x0;
err = tol + 1; difv=[ ];
x = x0;
if normtype == 2
    nor = 2;
else
    nor = inf;
end

while err >= tol && k < kmax
    % evaluation of the function f and its Jacobian at the current
    % approximation x^k of the solution of the non-linear system f(x) = 0
    J = Jfun(x,varargin{:});
    F = Ffun(x,varargin{:});
    % correction with respect to the previous approximation
    delta = - J\F;
    % computation of the new approximation
    x = x + delta;
    % error between two consecutive approximations
    err = norm(delta,nor);
    % matrix of differences between two consecutive approximations
    difv=[difv; err];
    % matrix of consecutive approximations
    x_vect = [x_vect x];
    k = k + 1;
end
res = norm(Ffun(x,varargin{:}));
if (k==kmax && err> tol)
    fprintf(['Method does not converge in the maximum ',...
       'number of iterations. The last computed iterate\n',...
       'has relative residual equal to %e\n'],F);
end
niter=k;
