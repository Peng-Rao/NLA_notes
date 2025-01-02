%{
	\renewcommand{\theenumi}{\alph{enumi}}
	\begin{enumerate}
	\setcounter{enumi}{0}
	\item Evaluate $f(x)$ for values of $x$ around zero (try with $x_k = 10^{-k}$, $k \in [1,20])$. What do you obtain? Explain the results.
	\end{enumerate}
%}
k = [1:20]';
x = 10.^(-k);
f = @(x) (exp(x) - 1) ./ x;
format long
[k x f(x)]

%{
	The computed $f(x_k)$ have the expected behavior until $k = 7$, in agreement with
	\[\lim_{x \to 0} f(x) = 1. \]
	
	Then, from $k=8$ to $k=15$, the sequence oscillates with increasing amplitude. Then, at $k = 16$, the result becomes 0! The cause of these effects is the \textbf{loss of accuracy} due to numerical cancellation. For $k = 8, ..., 15$ $e^{x_k}$ and 1 are very close to each other, still being different in floating point arithmetic. We are subtracting them and the result suffers of a great relative error. Moreover, we are dividing by $x_k$, that approaches 0, hence the error is magnified.
	
	Finally, for $k = 16$, $e^{x_k}$ and 1 are too close to have a different representation in the floating ploint arithmetic ($\texttt{eps} \approx 10^{-16})$, hence the difference is 0.
%}

%{
	\renewcommand{\theenumi}{\alph{enumi}}
	\begin{enumerate}
	\setcounter{enumi}{1}
	\item Propose an approach for fixing the problem. (Hint: Use Taylor expansions to get an approximation of $f(x)$ around $x = 0$.)
	\end{enumerate}
	
	Write the Taylor expansion of $e^x$ around $x_0 = 0$, truncating it at the fifth order:
	\begin{align*}
	e^x & = \sum_{k=0}^{+\infty} \frac{f^{(k)}(x_0)}{k!} (x-x_0)^k = \sum_{k=0}^{5} \frac{f^{(k)}(x_0)}{k!} (x-x_0)^k + O(x^6) = \\
		& = 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + \frac{x^4}{24} + \frac{x^5}{120} + O(x^6)
	\end{align*}
	and substitute it in $f(x)$
	\begin{align*}
	f(x) = 1 + \frac{x}{2} + \frac{x^2}{6} + \frac{x^3}{24} + \frac{x^4}{120} + O(x^5)
	\end{align*}
	Within this formula, at least for $x > 0$, all the terms have the same sign, so no numerical cancellation occurs.
%}

f_taylor_5 = @(x) 1 + 1/2*x + 1/6*x.^2 + 1/24*x.^3 + 1/120*x.^4;

[k x f(x) f_taylor_5(x)]

%{
	\renewcommand{\theenumi}{\alph{enumi}}
	\begin{enumerate}
	\setcounter{enumi}{2}
	\item How many terms in the Taylor expansion are needed to get double precision accuracy (16 decimal digits) $\forall x \in [0, 1/2]$?
	\end{enumerate}
	
	The error in the approximation of a function $g(x)$ at a point $x = a$ with its Taylor expansion up to order $n$ is
	\begin{equation*}
	E[g,n,a](x) = \frac{g^{(n+1)}(\xi)}{(n+1)!} (x-a)^{n+1} \qquad \text{for at least a $\xi$ s.t. } |\xi -a| \leq |x -a|
	\end{equation*}
	
	In this case
	\begin{equation*}
	E[e^x,n+1,0](x) = \frac{e^{\xi}}{(n+2)!} x^{n+2} \qquad \text{for } \xi \in [0,x]
	\end{equation*}
	and therefore, substituting in $f(x)$ 
	\begin{equation*}
	E[f,n,0](x) = \frac{E[e^x,n+1,0](x)}{x} = \frac{e^{\xi}}{(n+2)!} x^{n+1} \qquad \text{for } \xi \in [0,x]
	\end{equation*}
	
	We want 
	\begin{equation*}
	E[f,n,0](x) < \texttt{eps} \qquad \forall x \in \left[0, \frac{1}{2}\right]:
	\end{equation*}
	since both $e^\xi$ and $x^{n+1}$ are increasing functions, it's enough to choose $\xi = x = \frac{1}{2}$ and seek the first $\tilde{n}$ such that
	\begin{equation*}
	\frac{e^{1/2}}{(n+2)!} (1/2)^{n+1} < \texttt{eps}
	\end{equation*}
%}


format short e
n = [1:20]';
err = 1./factorial(n+2) .* (0.5).^(n+1).*exp(0.5);

[n err]

%{
	Therefore $\tilde{n} = 13$.
%}
