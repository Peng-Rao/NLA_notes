k = 0;
zero = 1/2;
while (0 + zero) > 0
  zero_old = zero;
  zero = zero / 2;
  k = k + 1;
end

% Remember: realmin is the minimum !normalized! positive floating point number
realmin
% The minimum positive floating point number is instead a !denormalized! number
zero_old % < realmin
k
