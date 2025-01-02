%{
	\begin{enumerate}
	\renewcommand{\theenumi}{\alph{enumi}}
	\setcounter{enumi}{0}
	\item Give an upper bound for $I_n(\alpha)$, $\forall n \in \mathbb{N}, \alpha > 0$.
	\end{enumerate}
	
	\begin{equation*}
		\int_0^1 \frac{x^n}{x+\alpha} \, \text{d}x \leq \int_0^1 \frac{x^n}{\alpha} \, \text{d}x = \frac{1}{\alpha} \frac{1}{n+1}
	\end{equation*}
	
	\begin{enumerate}
	\renewcommand{\theenumi}{\alph{enumi}}
	\setcounter{enumi}{1}
	\item Prove the following recursive relation between $I_n(\alpha)$ and $I_{n-1}(\alpha)$:
	\begin{equation*}
		\begin{cases}
		I_n(\alpha) = -\alpha I_{n-1}(\alpha) + \frac{1}{n}\\
		I_0(\alpha) = \ln\left(\frac{\alpha+1}{\alpha}\right)
		\end{cases}
	\end{equation*}
	\end{enumerate}
	It's a consequence of the following:
	\begin{equation*}
		I_n(\alpha) = \int_0^1 \frac{x^n}{x+\alpha} \, \text{d}x = \int_0^1 \frac{x^n + \alpha x^{n-1}}{x+\alpha} - \alpha \int_0^1 \frac{x^{n-1}}{x+\alpha}\, \text{d}x = + \frac{1}{n} - \alpha I_{n-1}(\alpha)
	\end{equation*}

	\begin{enumerate}
	\renewcommand{\theenumi}{\alph{enumi}}
	\setcounter{enumi}{2}	
	\item Employing the previous relation, compute $I_{40}(\alpha =  8)$ and comment the obtained results.
	\end{enumerate}
%}	

clear all;
format short e
n = 40;
% alpha = 1/8 not requested in the homework
for (alpha = [1/8, 8])
	I(1) = log((alpha+1)/alpha);
	for (k = 1:n)
		I(k+1) = -alpha*I(k) + 1/k;
	end
	recursion_integral = I(n+1);
	upper_bound = (1/alpha)*(1/(n+1));
	exact_integral = quadl(@(x) (x.^n)./(x+alpha), 0, 1, 1e-16); % Exact value (not requested)
	[recursion_integral, upper_bound, exact_integral]
end

%{
	The recursive approximation of $I_{40}(\alpha =  8)$ is $1.6389 \cdot 10^{18}$: this result is for sure incorrect because it violates the upper bound for $I_{40}(\alpha =  8)$.
	
	This is due to the finite precision we use and the error propagation: the initial value $I_0(\alpha) = \ln\left(\frac{\alpha+1}{\alpha}\right)$ is represented with a certain error $\eps$; denoting by $fl(y)$ the floating point representation of the number $y$, we have
	\begin{align*}
	fl(I_0(\alpha)) & = I_0(\alpha) + \eps,\\
	fl(I_1(\alpha)) & = -\alpha fl(I_0(\alpha)) + 1 = -\alpha (I_0(\alpha) + \eps) + 1 = I_1(\alpha) - \alpha \eps,\\
	... &\\
	fl(I_k(\alpha)) & = I_n(\alpha) + (-1)^k \alpha^k \eps,
	\end{align*}
	
	Therefore, at the final ($n$-th) step the error is multiplied by a factor $\alpha^n$, which result in an amplification of the error if $\alpha > 1$. Instead, for $\alpha < 1$, the error is damped and the recursive relation is stable (e.g. see the previous test for $\alpha = 1/8$).
	
	\begin{enumerate}
	\renewcommand{\theenumi}{\alph{enumi}}
	\setcounter{enumi}{3}
	\item Write a numerically stable recursive relation for $I_{40}(\alpha =  8)$.
	\end{enumerate}
	
	The idea is to transform the factor $\alpha$ on the RHS of the recursive relation in a factor $\frac{1}{\alpha}$; this can be achieved inverting the recursive relation:
	\begin{equation*}
		\begin{cases}
		I_{k-1}(\alpha) = - \frac{1}{\alpha} I_{k}(\alpha) + \frac{1}{k \alpha}\\
		lim_{k \to +\infty} I_{k}(\alpha) = 0
		\end{cases}
	\end{equation*}
	
	The final value $lim_{k \to +\infty} I_{k}(\alpha)$ is equal to zero because $0 \leq I_{k}(\alpha) \leq \frac{1}{\alpha} \frac{1}{k+1} \to 0$, as $k \to + \infty$.
%}

clear all;
n = 40;
big = 1000;
% alpha = 1/8 not requested in the homework
for (alpha = [1/8, 8])
	I(big + 1) = 0;
	for (k = big:-1:n+1)
		I(k) = -1/alpha*I(k+1) + 1/(k*alpha);
	end
	recursion_integral = I(n+1);
	upper_bound = (1/alpha)*(1/(n+1));
	exact_integral = quadl(@(x) (x.^n)./(x+alpha), 0, 1, 1e-16); % Exact value (not requested)
	[recursion_integral, upper_bound, exact_integral]
end

%{
	The recursion is now stable for $\alpha > 1$ (and note that, now, an additional error is present, because the final condition can be set for an arbitrary large $k = \overline{k}$ insteady of $k = +\infty$).
%}

