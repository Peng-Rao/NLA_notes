function [t,y] = forward_euler(f, y0, t0, T, h)
  %FORWARD_EULER Solves the ordinary differential equation y' = f(t, y), with
  %   y(0) = y0, in the nodes defined in t using Forward Euler method.
  %   y = FORWARD_EULER(f, y0, t0, T, h)
  %
  %   Inputs  : f  = function handle to the right hand side
  %             y0 = initial condition
  %             t  = nodes
  %   Outputs : y  = approximated solution in the nodes

  time_istants=floor((T-t0)/h);
  t=linspace(t0, T, time_istants+1);
  y(:, 1) = y0;

  for n = 2:length(t)
    y(:, n) = y(:, n-1) + h* f(t(n-1), y(:, n-1));
  end

end
