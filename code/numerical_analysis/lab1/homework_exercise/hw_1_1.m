%{
	\renewcommand{\theenumi}{\alph{enumi}}
	\begin{enumerate}
	\setcounter{enumi}{0}
	\item Implement the two relations in order to generate the first $100$ terms of the sequence.
	\end{enumerate}
%}
% First recursive relation
p(1) = 1;
p(2) = 1/3;

for i = 2:100
    p(i + 1) = 10/3 * p(i) - p(i - 1);
end

figure
subplot(2, 1, 1)
plot(0:100, p, 'LineWidth', 3)
set(gca, 'FontSize', 16)
xlabel('n', 'FontSize', 16)
ylabel('p_n', 'FontSize', 16)
% The sequence explodes!

% Second recursive relation
q(1) = 1;

for i = 1:100
    q(i + 1) = 1/3 * q(i);
end

subplot(2, 1, 2)
plot(0:100, q, 'LineWidth', 3)
set(gca, 'FontSize', 16)
xlabel('n', 'FontSize', 16)
ylabel('q_n', 'FontSize', 16)

% The sequence instead is ok.

%{
	\renewcommand{\theenumi}{\alph{enumi}}
	\begin{enumerate}
	\setcounter{enumi}{1}
	\item Study the stability of the two algorithms and justify the obtained results.
	\end{enumerate}
	Error analysis: since we use finite precision numbers, we know the initial data up to an error $\eps$\footnote{Actually, if we start from 1, we kno it exactly, but we may introduce anyway errors in the following steps.}

	Indeed, denoting by $fl(p_i)$ the floating point representative for $p_i$
	\begin{equation*}
	fl(p_0) = p_0 + \eps, \qquad fl(p_1) = p_1 + \eps.
	\end{equation*}

	It follows
	\begin{align*}
	fl(p_2) & = \frac{10}{3} fl(p_1) - fl(p_0) = \frac{10}{3}(p_1 + \eps)- (p_0 + \eps) = p_2 + \frac{7}{3} \eps\\
	fl(p_3) & = \frac{10}{3} fl(p_2) - fl(p_1) = \frac{10}{3}(p_2 +  \frac{7}{3}\eps) - (p_1 + \eps) = p_2 + \frac{61}{9} \eps\\
	\tilde{p}_4 & = ...
	\end{align*}

	The error is amplified!

	Instead, with the second formula
	\begin{align*}
	fl(q_0) & = q_0 + \eps\\
	fl({q}_1) & = \frac{1}{3} fl({q}_0) = \frac{1}{3} q_0 + \frac{1}{3} \eps = q_1 + \frac{1}{3} \eps\\
	fl({q}_2) & = \frac{1}{3} fl({q}_1) = \frac{1}{3} q_1 + \frac{1}{9} \eps = q_2 + \frac{1}{9} \eps\\
	fl({q}_3) & = ...
	\end{align*}

	The error is reduced!
%}
