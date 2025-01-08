function [c, a, b] = int_trigonometrico(I,n,f)

% Function that computes the coefficients of the trigonometric interpolator for f
%
% Input:
% I: vector of 2 components that contains the interpolation interval
% n: number of interpolation nodes minus 1
% f: function to be interpolated
%
% Output:
% c: coefficients of the trigonometric interpolator using Euler's formula
% a: coefficients of the cosines in the trigonometric interpolator 
%    expressed as a sum of sines and cosines
% b: coefficients of the sines in the trigonometric interpolator 
%    expressed as a sum of sines and cosines

M = n/2;
kk = -M:M;
% Note that for the trigonometric interpolator, by definition, only the first n+1 nodes are needed
xj = linspace(I(1), I(2), n+2);
h = (I(2) - I(1)) / (n+1);
fj = f(xj(1:end-1));

T = exp(-1i * h * (0:n).*(kk)') / (n+1);
c = T*fj';

a = c(M+2:end) + c(M:-1:1);
a = [c(M+1)+c(M+1); a];
b = 1i * (c(M+2:end) - c(M:-1:1));