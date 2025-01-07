%% Exercise 11.6
% Implement the Theta Method method in a suitable function
clc;clear; close all;
%%
f    = @(t,y) -2.*t.*y;
y_ex = @(t) exp(-t.^2);

theta = 0; %EE
%theta = 1/4;
theta = 1/2; % CN
%theta = 3/4;
%theta = 1; %EI
err=[];
for n = 4:8
  h = 2^(-n);
  
  
  [t,y] = theta_method(f, 1, 0, 1, h,theta);  
  err= [err max(abs(y - y_ex(t)))];
  
end

p = log( err(1:end-1)./(err(2:end) )) / log(2)
% The order of convergence is 1 for theta ~= 1/2 and 2 for theta = 1/2, as expected.

