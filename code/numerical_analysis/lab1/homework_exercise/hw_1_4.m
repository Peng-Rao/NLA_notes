clear all, close all, clc
format long

f_taylor_pos = @(x) 1 - x + 1/2*x.^2 - 1/6*x.^3 + 1/24*x.^4 - 1/120*x.^5;
f_taylor_neg = @(x) 1./(1 + x + 1/2*x.^2 + 1/6*x.^3 + 1/24*x.^4 + 1/120*x.^5);

k = [1:20]';

x_pos = 10.^(-k);
[x_pos f_taylor_pos(x_pos) f_taylor_neg(x_pos)]

x_neg = -10.^(-k);
[x_neg f_taylor_pos(x_neg) f_taylor_neg(x_neg)]

%{
	No bad behaviour is observed since the 1 in both formulas dominates the sum and numerical cancellation does not occur.
  Therefore both expression can be accepted.

	Instead, if the sum were not dominated by the term 1 (or if you didn't notice that),
    the following combination could have been proposed
	\begin{equation*}
	e^{-x} \approx
	\begin{cases}
	\frac{1}{1 + x + \dfrac{1}{2}x^2 + \dfrac{1}{6}x^3 + \cdots}, & x > 0;\\
	1 - x + \dfrac{1}{2}x^2 - \dfrac{1}{6}x^3 + \cdots, & x \leq 0.
	\end{cases}
	\end{equation*}

	The choice of the previous expression for $x > 0$ should not display any
  numerical cancellation because all the terms in the sum are positive.
  Similarly, the choice for $x < 0$ grants that the terms $-x^{2k+1}$ are
  positive, again avoiding any numerical cancellation.
%}
