clear all 
close all
clc
%% Point 1
% plot the function f and its two first derivatives
x = linspace (-2, 2, 1001);
fun = @(x) exp (x) - x.^2 - sin (x) - 1;

figure (1)
plot (x, fun (x), 'r', 'LineWidth', 2)
hold on, grid on
plot (x, zeros (size (x)), 'b')
xlabel ('x')
ylabel ('y')
title ('y = f (x)')

figure (2)           
dfun = @(x) exp (x) - 2*x - cos (x); 
plot (x, dfun (x), 'r', 'LineWidth', 2) 
hold on, grid on   
plot (x, zeros (size (x)), 'b')
xlabel ('x')          
ylabel ('y')          
title ('y = df (x)')   

figure (3) 
d2fun = @(x) exp (x) - 2 + sin (x); 
plot (x, d2fun (x), 'r', 'LineWidth', 2)
hold on, grid on  
plot (x, zeros (size (x)), 'b')  
xlabel ('x')         
ylabel ('y')         
title ('y = d2f (x)')     

% x=0 multiplicity m=2
% x=1.2797 simple root
%% Point 2
% Newton Method for the root with multiplicity m=2
x0 = 0.1; 
nmax = 100; 
tol = 1e-6;     
disp ('Newton Method for the root with multiplicity m=2')
[x, xvect] = newton (fun,dfun, x0,tol, nmax);

% Estimate of the order and the convergence factor
[p, c] = estimatep (xvect);

% Grafico dell'errore in funzione delle iterazioni
x1 = 0;                     
err_exact = abs (xvect - x1);         
figure (4)   
semilogy (1:numel(err_exact ), err_exact , 'b*')       
grid on                     
xlim ([1, numel(err_exact )])                 
xlabel ('iterations')              
ylabel ('error')                
title ('Linear Convergence for Newton on x = 0')

%% Point 3
% Newton Method for the simple root
x0 = 1.2; 
disp ('Newton Method for the simple root')
[x, xvect] = newton (fun,dfun, x0,tol, nmax);

% estimate of the order and the convergence factor
[p, c] = estimatep (xvect); 

% Plot of the error as function of the iterations
x2 = 1.279701331000996;                 
true_error = abs (xvect - x2);             
figure (5)                       
semilogy (1:numel(true_error), true_error, 'b*')         
grid on                         
xlabel ('iterations')                  
ylabel ('error')                    
title ('Quadratic Convergence for Newton on x = 1.27..')

