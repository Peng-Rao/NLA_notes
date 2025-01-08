%% Exercise 9.4
clear all; close all

M  = 2;
k  = -M:M;
n  = 2*M;
N  = [0:n];
h  = 2*pi/(n+1);

xj = N*h;

x = linspace (xj(1), xj(end), 1000).';
figure (1)
phiT=[];
for jj = N
  phit = 1/(n+1)*sum (exp (1i * k' * (x' - h*jj)));
  plot (x, phit)
  phiT=[phiT phit'];
  hold all
end
title ("trigonometric lagrangian basis")

%%
figure (2)
hold on, box on

phi=zeros(numel(xj), numel(xj));
for j = 1:numel(xj)
	
	nodes = setdiff(xj, xj(j));
	
	phi(:, j) = poly(nodes) / polyval(poly(nodes), xj(j));
    plot(x, polyval(phi(:, j), x),  'LineWidth', 2)  
 
end

title ("polynomial lagrangian basis")
