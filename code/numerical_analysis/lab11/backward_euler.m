function [t, y, iter] = backward_euler(f, y0, t0, T, h)
  %BACKWARD_EULER Solves the ordinary differential equation y' = f(t, y), with
  %   y(0) = y0, in the nodes defined in t using Backward Euler method.
  %   y = BACKWARD_EULER(f, y0, t0, T, h)
  %
  %   Inputs  : f  = function handle to the right hand side
  %             y0 = initial condition
  %             t  = nodes
  %   Outputs : y  = approximated solution in the nodes

  time_istants=floor((T-t0)/h);
  t=linspace(t0, T, time_istants+1);
  y(:, 1) = y0;
  iter=[];
  for n = 2:length(t)
    [y(:, n), ~,~, output] = fsolve(@(z) -z + y(:, n-1) + h*f(t(n), z), ...
    	y(:, n-1), optimset('Display', 'off', 'MaxIter', 1000) );
    iter=[iter output.iterations];
  end

end
