clear; clc; close all;

%% define the function
f = @(x) 3 * sin(pi / 3 * x) - exp(-3 * x);

%% composite trapezoidal rule to compute n = 8, 16, 32, 64
a = 0;
b = 1;
I_m_8 = composite_trapezoidal(f, a, b, 8);
I_m_16 = composite_trapezoidal(f, a, b, 16);
I_m_32 = composite_trapezoidal(f, a, b, 32);
I_m_64 = composite_trapezoidal(f, a, b, 64);

%% calculate the error
Iex = 9 / (2 * pi) + (exp(-3) - 1) / 3;
Iappr=[I_m_8; I_m_16; I_m_32; I_m_64];
err = abs(Iex * ones(4,1) - Iappr);

% Comment
% Analyzing the errors found in the previous step, it is observed that 
% by doubling n(i.e., halving h = 2/n), the error becomes approximately
% a quarter of its previous value. 
% This is in line with the theory, which states that the error satisfies
% |I - I_n| = O(h^2).

% Plot the error as a function of h to graphically verify the behavior predicted by theory.
n = [8 16 32 64];
h = (b-a) ./ n;
figure()
loglog(h, err, 'g', 'LineWidth', 2)
hold on
loglog(h,h.^2,'r--','LineWidth', 2)
legend('err','hˆ2', 'Location','northwest')

%% Repeat part a using the function
f = @(x) -3 * x + 7;
I_m_8 = composite_trapezoidal(f, a, b, 8);
I_m_16 = composite_trapezoidal(f, a, b, 16);
I_m_32 = composite_trapezoidal(f, a, b, 32);
I_m_64 = composite_trapezoidal(f, a, b, 64);