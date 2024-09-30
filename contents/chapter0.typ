#import "../template.typ": *
#import "@preview/codelst:2.0.1": sourcecode

= Principles of Numerical Mathematics

== Well-posedness and Condition Number of a Problem

Consider the following problem: find $x$ such that:

$ F(x,d) = 0 $ <1>

where $F$ is a function of $x$ and $d$. And three types of problems can be considered:
+ _direct problem_: given $F$ and $d$, find $x$;
+ _inverse problem_: given $F$ and $x$, find $d$;
+ _identification problem_: given $x$ and $d$, find $F$.

Problems @1 are well-posed if it admits a _unique_ solution, and the solution depends continuously on the data.

A problem which does not enjoy the property above is called ill posed or unstable and before undertaking its numerical solution it has to be regularized, that is, it must be suitably transformed into a well-posed problem.

Let $D$ be the set of admissible data, i.e. the set of the values of $d$ in correspondance of which problem @1 admits a unique solution. Continuous dependence on the data means that small perturbations on the data d of $D$ yield “small” changes in the solution $x$.

#example[
  For example, a _well-posed(well-conditioned)_ problem is one with the property that all small perturbations of $x$ lead to only small changes in $f(x)$. An _ill-posed(ill-conditioned)_ problem is one for which small perturbations of $x$ can lead to large changes in $f(x)$.
]

Precisely, let $d in D$ and denoted by $delta d$ a perturbation admissible in the sense that $d + delta d in D$ and by $delta x$ the corresponding change in the solution, in such a way that:

$ F(x + delta x, d + delta d) = 0 $ <2>

Then, we require that:

$
  exists eta_0 = eta_0(d) > 0, exists K_0=K_0(
    d
  ) text("such that") \ text("if") norm(delta d) lt.eq.slant eta_0 text("then") norm(delta x) lt.eq.slant K_0 norm(delta d)
$ <3>

The norms used for the data and for the solution may not coincide, whenever $d$ and $x$ represent variables of diﬀerent kinds.

The @3 is however more suitable to express in the following the concept of _numerical stability_, that is, the property that small perturbations on the data yield perturbations of the same order on the solution.

#definition("Condition Number")[
  For problem @1, we define the _relative conditional number_ to be:

  $ K(d)= sup{(norm(delta x) / norm(x)) / (norm(delta d) / norm(d)), delta d eq.not 0, d+delta d in D} $

  Whenever $d=0$ or $x=0$, it is nessesary to consider the _absolute conditional number_:

  $ K_("abs")(d)= sup{norm(delta x) / norm(delta d), delta d eq.not 0, d+delta d in D} $
]

=== Absolute Condition Number

If $f$ is differentiable, we can evaluate the absolute condition number by means of the derivative of $f$. Let $J(x)$ be the matrix whose $i, j$ entry is the partial derivative $partial f_i slash partial x_j$, evaluated at $x$. The definition of derivative gives us, $delta f #sym.approx J(x)delta x$, with equality in the limit $norm(delta x) arrow 0$. The absolute condition number is then:

$ K=norm(J(x)) $

=== Relative Condition Number

If $f$ is differentiable, we can express this equality in terms of the Jacobian matrix $J(x)$, as follows:

$ K = norm(J(x)) / (norm(f\x) slash norm(x)) $

Problem @1 is called _ill-conditioned_ if $K(d)$ is “big” for any admissible datum d (the precise meaning of “small” and “big” is going to change depending on the considered problem).

== Stability of Numerical Methods

We shall henceforth suppose the problem @1 to be well-posed and a numerical method for the approximate solution of @1 will consist, in general, of a sequence of approximate problems:

$ F(x_n,d_n) = 0 $ <problem2>

depending on a certain parameter n (to be defined case by case). The undetstood expectation is that $x_n arrow x$ as $n arrow infinity$, that is, the sequence of approximate solutions *converges* to the exact solution.

For that, it is necessary that $d_n arrow d$ and $F_n arrow F$, as $n arrow infinity$. Precisely, if the datum $d$ of @1 is admissible for $F_n$, we say that @problem2 is consistent if:

$ F_n(x,d) = F_n(x, d) - F(x, d) arrow 0 text("for") n arrow infinity $ <5>

=== Relations between Stability and Covergence

The concepts of stability and convergence are strongly connected.

#theorem[
  If problem @1 is well-posed, a _necessary_ condition in order for the numerical problem @problem2 to be convergent is that it is stable.
]