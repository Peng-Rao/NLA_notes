function [p,c] = estimatep(xvect)
%
% [p,c] = estimatep(xvect)
% Estimate convergence order and error reduction factor 
% of an iterative method for the computation of the 
% zeros of a function using the following formulas:
%
%          
%           | x_(k+1) - x_k |
%       ln -------------------
%           | x_k - x_(k-1) |       
% p = ------------------------------
%           | x_k - x_(k-1) |       
%       ln -----------------------
%           | x_(k-1) - x_(k-2) |
%
%        | x_(k+1) - x_k |
% c = -------------------------
%       | x_(k) - x_(k-1) |^p  
%
% Input parameters:
%
% xvect = Vector containing all the computed zeros
%
% Parametri di uscita:
%
% p =  Vector containing all the estimated convergence orders
% c =  Vector containing all the estimated error reduction factors


it = max(size(xvect));

for i = 3:it-1
  diff1 = abs (xvect(i + 1) - xvect(i));
  diff2 = abs (xvect(i) - xvect(i - 1));
  diff3 = abs (xvect(i - 1) - xvect(i - 2));
  if (diff1 * diff2 * diff3 == 0) 
    disp(' Attenzione: due valori di xvect coincidenti');
    break;
  else
    num = log(diff1 / diff2);
    den = log(diff2 / diff3);
    p(i) = num / den;
    c(i) = diff1 / diff2 ^ p(i);
  end
end

dim = max(size(p));
if (it > 3)
  fprintf (' Estimated Order      : %12.8f \n', p(dim));
  fprintf (' Reduction Factor     : %12.8f \n', c(dim));  
else
  disp (' Unsufficient number of iterations !!!')
end
return

% Explanation. 
%-------------
% Let e_k = |x_k - alfa|. If a numerical iterative method satisfies asymptotically
% e_k+1 = c * (e_k)^p , we say that the method has convergence order p and reduction factor c. 

% Illustration of the estimate.
%---------------------------
% We have:  e_k+1/(e_k)^p = e_k /(e_k-1)^p, then e_k+1/e_k = (e_k / e_k-1)^p, then
% p = log_{e_k/e_k-1}(e_k+1/e_k) = ln(e_k+1/e_k)/ln(e_k/e_k-1).
% Approximately we have: e_k con x_k+1 - x_k.
