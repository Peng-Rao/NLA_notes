%{
	\begin{enumerate}
	\renewcommand{\theenumi}{\alph{enumi}}
	\setcounter{enumi}{0}
	\item Set $x_0 = 1$, compute $x_1,\ x_2,\ \ldots,\ x_{71}$ and explain the obtained results.
	\end{enumerate}
%}	
clear all, close all, clc
format long

n_max = 71;
x = zeros(n_max+1, 1);

x(1) = 1;         % x_0 set to 1
for n = 0:n_max-1
  x(n+2) = 2^(n+1)*(sqrt(1 + x(n+1)/2^n) - 1);    % Pay attention to the indexing!!!
end
x(end)            
x_lim = log(1 + x(1))

figure
hold on, box on
plot([0:71], x, 'bx-','Linewidth',3)
plot([0:71], x_lim*ones(n_max+1,1)', 'r-','Linewidth',3)
axis([-1 72 -0.05 1.05])
set(gca,'LineWidth',2)
set(gca,'FontSize',16)

%{
	When computing the sequence with MATLAB we find that $x_{71}$ differs a lot from $\ln(1+x_0) = \ln(2)$. The plots also shows that $x_n = 0$, $\forall n \geq n^* = 52$: this is due to numerical cancellation effects, because at $n = n^*$ it holds $\frac{x_{n^*}}{2^{n^*}} < \texttt{eps}$, hence in finite precision arithmetic $x_{n^*} = 0$!
%}
x(53)

%{
	The value of $n^*$ can also be computed with the following argument: since (hopefully) numerical cancellation will occur for large $n$
	\[x_{n} \approx \ln(1+x_0) \]
	therefore
	\[\frac{x_{n}}{2^{n}} < \texttt{eps} \text{ is approximately equivalent to } \frac{\ln(1+x_0)}{2^{n}} < \texttt{eps}\]
	which can be solved for $n$, finding
	\[n > \log_2\left( \frac{\ln(1+x_0)}{\texttt{eps}}  \right)\]
%}
x_0 = 1;
n = log(log(1 + x_0)/eps)/log(2)

%{
	\begin{enumerate}
	\renewcommand{\theenumi}{\alph{enumi}}
	\setcounter{enumi}{1}
	\item Transform the sequence in an equivalent one that converges to the theoretical limit.
	
	After a razionalization, the recurrence can be written as
	\[  x_{n+1} = 2^{n+1} \left[\sqrt{1+\dfrac{x_n}{2^{n}}} - 1 \right] = \frac{2 x_n}{\sqrt{1+\dfrac{x_n}{2^{n}}} + 1} \]
	\end{enumerate}
%}	
clc, clear all

n_max = 71;
x = zeros(n_max+1, 1);

x(1) = 1;           % x_0 set to 1
for n = 0:n_max-1
  x(n+2) = 2*x(n+1)/(sqrt(1 + x(n+1)/2^n) + 1);
end
x(end)

% The error in this case is
x(end) - log(1 + x(1))

figure
hold on, box on
plot([0:n_max], x,'bx-','Linewidth',3)
plot([0:n_max], log(1+x(1))*ones(n_max+1), 'r-','Linewidth',3)
axis([-1 72 0.67 1.02])
set(gca,'LineWidth',2)
set(gca,'FontSize',14)

% Using the previous calculations we know that (1 + xn/2^n) approximately 1 for n >= 52, so x_(n+1) = 2*x_n/(1 + 1) = x_n

