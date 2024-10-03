#import "../template.typ": *

= Norms

The essential notions of *size and distance* in a vector space are captured by norms. These are the _yardsticks_ with which we measure approximations and convergence throughout numerical linear algebra.

== Vector Norms

A norm is a function $norm(dot): CC^m arrow RR$ that assigns a real-valued length to each vector. In order to conform to a reasonable notion of length, a norm must satisfy the following three conditions. For all vectors $x, y$ and for all scalars $alpha in CC$:

#block[
  + _Nonnegativity_: $norm(x) gt.eq 0$ and $norm(x) = 0$ if and only if $x = 0$.
  + _Triangle Inequality_: $norm(x + y) lt.eq norm(x) + norm(y)$.
  + _Homogeneity_: $norm(alpha x) = |alpha| norm(x)$.
]

The above conditions allow for different notions of lenght, and at times it is useful to have the flexibility.
$
  norm(x)_1 &= sum_(i=1)^m |x_i| \
  norm(x)_2 &= sqrt(sum_(i=1)^m |x_i|^2) \
  norm(x)_(infinity) &= max_{1 < i < m} |x_i| \
  norm(x)_p &= (sum_(i=1)^m |x_i|^p)^(1 / p) (p lt.eq 1 lt infinity)
$
Aside from the $p-"norms"$, the most useful norms are the _weighted p norms_, where each of the coordinates of a vector space is given its own weight. In general, given any norm $norm(dot)$, the _weighted p norm_ is defined as:
$ norm(x)_w = norm(W\x) $
Here $W$ is the diagonal matrix with the $i$th diagonal entry is the weight $w_i eq.not 0$. For example. a weighted 2-norm is specified as follows:
$
  norm(x)_W=(sum_(i=1)^m |w_i x_i|^2)^(1 / 2)
$
#theorem("Cauchy-Schwarz Inequality")[
  For any two vectors $x, y in RR^n$, the following inequality holds:
  $ |(x,y)| = |x^T y| lt.eq norm(x)_2 norm(y)_2 $
  Where strict equality holds if and only if $x$ and $y$ are linearly dependent.

  We recall that the scalr product in $RR^n$ can be realyed to the p-norms by the H\"older inequality:

  $ |(x,y)| lt.eq norm(x)_p norm(y) _q #h(1cm) "Where" #h(1cm) 1/p + 1/q = 1 $.
]

#theorem[
  Any vector norm $norm(dot)$ defined on V is a continous function of its argument, namely, $forall > 0, exists C > 0$ such that if $norm(x-hat(x)) lt.eq epsilon$ then $norm(x)-norm(hat(x)) lt.eq C epsilon$, for any $x, hat(x) in V$.
]

#theorem[
  let $norm(dot)$ be a norm of $RR^n$ and $A in RR^(n times n)$ be a matrix with n linearly independent columns. Then, the function $norm(dot)_(A^2)$ acting from $RR^n$ in to $RR$ defined as:

  $ norm(x)_(A^2) = norm(A\x) $

  is a norm on $RR^n$.
]

#theorem[
  Let $norm(dot)$ be a norm in a finite dimensional space V. Then:
  $
    lim_(k arrow infinity) x^((k))=x arrow.l.r.double.long lim_(k arrow infinity) norm(x^((k))-x)=0
  $
  where $x in V$ and $x^((k))$ is a sequence of vectors in V.
]

== Matrix Norms

In dealing with a space of matrices, certain special norms are more useful thant the vector norms. These are the _induced matrix norms_, defined in terms of the behavior of a matrix as an operator between its normed domain and range spaces.

Given vector norms $norm(dot)_(n)$ and $norm(dot)_(m)$ on the domain and the range of $A in CC^(m times n)$, respectively, the induced matirx norm $norm(A)_((m, n))$ is the smallest number $C$ for which the following inequality holds for all $x in CC^n$:

$ norm(A\x)_((m)) lt.eq C norm(x)_((n)) $

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