clear; clc; close all;

%% define the function
f = @(x) (x .* (x .^ 3 + 7 * x + 2) + 6) / (x .^2 + 3) .^ 2;

%% compute the approximate integral n = 4, 8, 16, 32
format long e
a = 0;
b = 1;
I_m_4  = composite_simpson(f, a, b, 4);
I_m_8  = composite_simpson(f, a, b, 8);
I_m_16  = composite_simpson(f, a, b, 16);
I_m_32  = composite_simpson(f, a, b, 32);

%% Knowing that I(f)=5/6, calculate the error using n = 4, 8, 16, 32
Iex = 5/6;
Iappr =[ I_m_4 ; I_m_8 ; I_m_16 ; I_m_32 ] ;
err = abs( Iex *ones(4 ,1) - Iappr);

% Comment
% According to theory, the error in the composite Simpson's rule is proportional 
% to h^4. Consistent with this prediction, doubling the number of subdivisions, 
% and thus halving their size, reduces the error by a factor of 2^4 = 16, 
% as shown by the following ratios:
format default
display(err(1) / err(2));
display(err(2) / err(3));
display(err(3) / err(4));


%% Plot the error as a function of h to graphically verify the behavior predicted by theory.
n = [4 8 16 32] ;
h = (b-a) ./ n ;
figure
loglog(h, err, 'g', 'LineWidth',2)
hold on
loglog(h, 1.1*h.^4/h(1)^4*err(1),'*r--' ,'LineWidth',2)
legend ( 'err', 'h^4')

%% Repeat part a using the function
f = @(x) -3 * x .^ 2 + 7 * x;
format long e
a = 0;
b = 1;
I_m_4  = composite_simpson(f, a, b, 4);
I_m_8  = composite_simpson(f, a, b, 8);
I_m_16  = composite_simpson(f, a, b, 16);
I_m_32  = composite_simpson(f, a, b, 32);

% Comment
% It is easily verified that the exact value of the integral is 5/2
% Therefore, the code returns the exact result, apart from truncation errors,
% regardless of the number of subdivisions used. This is consistent with 
% the theoretical result that Simpson's rule has an accuracy of degree 3,
% meaning it integrates polynomials of degree less than or equal to 3 
% exactly, such as the one proposed in this exercise.