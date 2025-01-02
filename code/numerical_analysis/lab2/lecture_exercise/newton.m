function [x,x_iter]=newton(f,df,x0,tol,Nmax)
%NEWTON Find a root of the equation f(x) = 0 using the Newton method, starting from the initial guess x0.
%
%   [xi, x_iter] =  NEWTON(f, df, x0, tol, maxit)
%
%   Inputs  : f     = function handle to the function f(x)
%             df    = function handle to the derivative of the function f(x)
%             x0    = initial guess
%             tol   = requested tolerance
%             Nmax  = maximum number of iterations
%   Output  :
%			xi = approximation of the root
%			x_iter     = vector of the approximations of the root at each step

ii=1;
err=1+tol;
% or we can set
% err = inf;
x_iter(ii)=x0;

while ii<=Nmax && err>tol
    f_x=f(x_iter(ii));
    df_x= df(x_iter(ii));
    if(abs( df_x) < 1e-8) % check if the derivative (denominator) is zero (or very small)
        fprintf("The derivative of f in %d approaches or is equal to zero", x_iter(i))
        break;
    end
    
    %delta=-df_x\f_x;
    %x_iter(i+1)=x_iter(i)+delta;
    %err=abs(delta);
    
    x_iter(ii+1)=x_iter(ii)-f_x/df_x;
    err=abs(x_iter(ii+1)-x_iter(ii));
    
    
    ii=ii+1;
    if(ii==Nmax)
        fprintf("Maximum number of iteration reached. Newton did not converge!\n")
        
    end
end

x=x_iter(end);
end