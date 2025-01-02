format long

%{
	\begin{enumerate}
	\renewcommand{\theenumi}{\alph{enumi}}
	\setcounter{enumi}{0}
	\item Use Taylor polynomial approximation to avoid the loss of significance errors in the following function when $x$ approaches $0$
\begin{equation*}
f(x) \, = \, \dfrac{1-\cos(x)}{x^2}
\end{equation*}
	\end{enumerate}

	The limit of $f(x) = \dfrac{1-\cos(x)}{x^2}$ as $x \to 0$ is well known:
	\begin{equation*}
	\lim_{x\to 0} \dfrac{1-\cos(x)}{x^2} = \frac{1}{2}
	\end{equation*}
%}
clear all, close all, c
k = [1:30]';
x = 2 .^ (-k);
f = @(x) (1 - cos(x)) ./ (x .^ 2);
[k x f(x)]

%{
	If we try to evaluate $f(x)$ directly with a sequence $\{x_k = 2^{-k}\}_k$ that approaches 0, we notice anamalous behaviour at $k = 13$, $k = 27$, $k = ...$.

	The reason is numerical cancellation of the terms on the numerator. We can use Taylor expansion of $\cos(x)$ for $x \to 0$ to obtain a better approximation. Indeed
	\begin{equation*}
		\cos(x) = 1 -\frac{1}{2}x^2 + \frac{1}{24}x^4 - \frac{1}{720}x^6 + o(x^8)
	\end{equation*}
	so that
	\begin{equation*}
		f(x) = \frac{1}{2} - \frac{1}{24}x^2 + \frac{1}{720}x^4 + o(x^6)
	\end{equation*}
%}
f_taylor_4 = @(x)1/2 - x .^ 2/24 + x .^ 4/720;

[k x f(x) f_taylor_4(x)]

%{
	The obtained formula is more stable that the direct evaluation of f(x), and the computed values approach $\frac{1}{2}$.
%}

%{
	\begin{enumerate}
	\renewcommand{\theenumi}{\alph{enumi}}
	\setcounter{enumi}{1}
	\item Reformulate the following function $g(x)$ to avoid the loss of significance error in its evaluation for increasing values of $x$ towards $+\infty$
	\begin{equation*}
	g(x) \, = \, x \Big (\sqrt{x+1} - \sqrt{x} \Big).
	\end{equation*}
	\end{enumerate}

	It is well known that
	\begin{equation*}
	\lim_{x \to +\infty} g(x) = +\infty
	\end{equation*}
%}
clear all, close all, clc
format short e

k = [1:20]';
x = 10 .^ (k);

g = @(x) x .* (sqrt(x + 1) - sqrt(x));

[k x g(x)]

%{
	If we try to evaluate $g(x)$ for a sequence $\{x_k = 10^{k}\}_k$ that approaches 0, we notice anamalous behaviour at $k = 16$, $k = ...$, for which the computed value is 0. This happens since, in floating point representation, $x_{16} + 1 = x_{16}$!

	Rationalization of the expression in bracket solves this numerical cancellation: indeed, multiplying the numerator and the denominator by $\sqrt{x+1} + \sqrt{x}$
	\begin{equation*}
	g(x)  = \frac{x \left(\sqrt{x+1} - \sqrt{x} \right)\left(\sqrt{x+1} + \sqrt{x}\right)}{\left(\sqrt{x+1} + \sqrt{x}\right)} = \frac{x}{\left(\sqrt{x+1} + \sqrt{x}\right)}.
	\end{equation*}
%}

g2 = @(x) x ./ (sqrt(x + 1) + sqrt(x));

[k x g(x) g2(x)]

%{
	This formula is more stable and does not suffer of numerical cancellation.
%}
