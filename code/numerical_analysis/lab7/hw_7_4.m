% Define the quadratic form as Phi(x, y)
syms x y;

Phi = x^2 - 4*x + y^2 - y - x*y;

% Compute the partial derivatives
dPhi_dx = diff(Phi, x);
dPhi_dy = diff(Phi, y);

% Solve the gradient equations (∇Phi = 0)
[sol_x, sol_y] = solve([dPhi_dx == 0, dPhi_dy == 0], [x, y]);

% Evaluate the function at the critical point
min_value = subs(Phi, [x, y], [sol_x, sol_y]);

% Display the results
disp('The critical point is:');
disp([sol_x, sol_y]);

disp('The minimum value of Phi is:');
disp(double(min_value));