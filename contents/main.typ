#import "../template.typ": *
#import "@preview/codelst:2.0.1": sourcecode

#show: template.with(
  title: [ Numerical Linear Algebra ],
  date: datetime(year: 2024, month: 9, day: 16),
  authors: (
    (
      name: "Rao",
      github: "https://github.com/Raopend",
      homepage: "https://github.com/Raopend",
    ),
  ),
  affiliations: (
    (
      id: "1",
      name: "Politecnico di Milano",
    ),
  ),
  // cover-image: "./figures/polimi_logo.png",
  background-color: "#FAF9DE",
)
#set math.mat(delim: "[")
#set math.vec(delim: "[")
#set math.equation(supplement: [Eq.])

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

#definition[
  A _matrix norm_ is a mapping $norm(dot): RR^(m times n) arrow RR$ such that:

  #block[
    + $norm(A) gt.eq 0 forall A in RR^(m times n) "and" norm(A)=0$ if and only if $A=0$.
    + $norm(alpha A) = |alpha| norm(A) forall A in RR^(m times n) "and" alpha in CC$.
    + $norm(A+B) lt.eq norm(A) + norm(B) forall A, B in RR^(m times n)$.(triangular inequality)
  ]
] <matrixnorm>



#definition[
  We say that a matrix norm $norm(dot)$ is _compatible_ or _consistent_ with a vector norm $norm(dot)$ if:
  $
    norm(A\x) lt.eq norm(A) norm(x) #h(1cm) forall x in RR^n
  $
  More generally, given three norms, all denoted by $norm(dot)$, albeit defined on $RR^m, RR^n. RR^(m times n)$, respectively, we say that they are consistent if if $forall x in RR^n, A\x=y in RR^m$, we have that $norm(y) lt.eq norm(A) norm(x)$.
]

#definition[
  We say that a matrix norm $norm(dot)$ is sub_multiplicative if $forall A in RR^(n times m), forall B in RR^(m times q)$ we have that $
  norm(A\B) lt.eq norm(A) norm(B) $
]

The norm
$
  norm(A)_F = sqrt(sum_(i=1)^m sum_(j=1)^n |a_(i\j)|^2)=sqrt(tr(A A^H))
$
is a matrix norm called the _Frobenius norm_. And it is compatible with the Euclidean vector norm $norm(dot)_2$. Indeed.
$
  norm(A\x)_2^2=sum_(i=1)^m |sum_(j=1)^n a_(i\j) x_j|^2 lt.eq sum_(i=1)^m sum_(j=1)^n |a_(i\j)|^2 sum_(j=1)^n |x_j|^2=norm(A)_F^2 norm(x)_2^2
$

#theorem[
  Let $norm(dot)$ be a vector norm. The function:
  $
    norm(A)=sup_(x eq.not 0) norm(A\x) / norm(x)
  $
  is a matrix norm called _induced matrix norm or natural matrix norm._

  \ *Proof*: Check @matrixnorm.
  \ 1. If $norm(A x) gt.eq 0$, then it follows that $norm(A) = sup_(norm(x)=1) norm(A x) gt.eq 0$. Moreover,
  $
    norm(A)=sup_(x eq.not 0) norm(A x) / norm(x) = 0 arrow.r.l.double.long norm(A x)=0 forall x eq.not 0
  $
  and $A x=0 forall x eq.not 0$ if and only if $A=0$; therefore, $norm(A)=0$ if and only if $A=0$.
  \ 2. Given a scalar $alpha$, we have that:
  $
    norm(alpha A)=sup_(x eq.not 0) norm(alpha A x) / norm(x) = sup_(x eq.not 0) |alpha| norm(A x) / norm(x) = |alpha| sup_(x eq.not 0) norm(A x) / norm(x) = |alpha| norm(A)
  $
  \ 3. Finally, triangular inequality holds. Indeed, by definition of supremum, if $x eq.not 0$ then:
  $
    (norm(A x)) / norm(x) lt.eq norm(A) arrow.double norm(A x) lt.eq norm(A) norm(x)
  $
  So that, taking $x$ with unit norm, one gets:
  $
    norm((A+B) x) lt.eq norm(A x) + norm(B x) lt.eq norm(A) + norm(B)
  $
  from which it follows that $norm(A+B)=sup_(norm(x)=1) norm((A+B)x) lt.eq norm(A) + norm(B)$.
]

Relevant instances of induced matrix norms are the so-called _p-norms_:
$
  norm(A)_p = sup_(bold(x) eq.not 0) norm(A bold(x))_p / norm(bold(x))_p
$

The 1-norm(column sum norn):
$
  norm(A)_1 = max_(j=1, dots, n)^n sum_(i=1)^m |a_(i\j)|
$

The infinity-norm(row sum norm):
$
  norm(A)_(infinity) = max_(i=1, dots, m)^m sum_(j=1)^n |a_(i\j)|
$

Moreover, we have $norm(A)_1=norm(A^T)_infinity$ and, if $A$ is self-adjoint or real sysmetric, then $norm(A)_1=norm(A)_infinity$.

A special discussion is deserved by the _2-norm_ or _spectral norm_ for which the following theorem holds.

#theorem("Spectral Norm")[
  Let $sigma_1(A)$ be the largest singular value of $A$. Then, the 2-norm of $A$ is given by:

  $ norm(A)_2 = sqrt(rho(A^H A)) = sqrt(rho(A^H A)) = = sigma_1(A) $

  In particular, if $A$ is hermitian (or real and symmetric), then $norm(A)_2 = rho(A)$.

  \ *Proof*. Since $A^T A$ is hermitian, there exists a unitary matrix $U$ such that $ U^H A^H A U = "diag"(mu_1, dots, mu_n) $
  where $mu_i$ are the positive eigenvalues of $A^H A$. Let $y=U^H x$, then:

  $
    norm(A_2)= &sup_(x eq.not 0) sqrt((A^H A x, x)) / sqrt((x, x)) = sup_(y eq.not 0) sqrt((U^H A^H A U y "," y)) / sqrt((y "," y)) \ = &sup_(y eq.not 0) sqrt(sum_(i=1)^n mu_i |y_i|^2) / sqrt(sum_(i=1)^n |y_i|^2) = sqrt(max_(i=1, dots, n)^n |mu_i|)
  $
  If $A$ is hermitian, the same considerations as above apply directly to $A$.
  Finally, if $A$ is unitary, we have
  $
    norm(A)_2 = sup_(x eq.not 0) norm(A x)_2 / norm(x)_2 = sup_(x eq.not 0) norm(x)_2 / norm(x)_2 = 1
  $
]

= Principles of Numerical Mathematics
== Well-posedness and Condition Number
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
Let $delta x$ denote a small perturbation of $x$, and wirte $delta f = f(x + delta x, d) - f(x, d)$. The absolute condition number is then defined as:
$ k=lim_(delta arrow 0) sup_(norm(delta x) lt.eq delta) norm(delta f) / norm(delta x) $
For most problems, the limit of the supremum in this formula can be interpreted as a supremum over all infinitesimal perturbations $delta x$, and in the interest of readability, we shall generally write the formula simply as
$ K=sup_(delta x) norm(delta f) / norm(delta x) $
with the understanding that $delta x$ and $delta f$ are infinitesimal.

If $f$ is differentiable, we can evaluate the absolute condition number by means of the derivative of $f$. Let $J(x)$ be the matrix whose $i, j$ entry is the partial derivative $partial f_i slash partial x_j$, evaluated at $x$. The definition of derivative gives us, $delta f #sym.approx J(x)delta x$, with equality in the limit $norm(delta x) arrow 0$. The absolute condition number is then:
$ K=norm(J(x)) $
=== Relative Condition Number

When we are concerned with relative changes, we need the notion of relative condition. The _relative condition number_ is defined as:
$
  K = lim_(delta arrow 0) sup_(norm(delta x) lt.eq delta) (norm(delta f) / (norm(f(x))) slash norm(delta x) / norm(x))
$
or, assuming $delta x$ and $delta f$ are infinitesimal,
$
  K = sup_(delta x) (norm(delta f) / norm(f(x))) / (norm(delta x) / norm(x))
$
If $f$ is differentiable, we can express this equality in terms of the Jacobian matrix $J(x)$, as follows:

$ K = norm(J(x)) / (norm(f\x) slash norm(x)) $

Problem @1 is called _ill-conditioned_ if $K(d)$ is “big” for any admissible datum d (the precise meaning of “small” and “big” is going to change depending on the considered problem).

=== Codution of Matrix-Vector Multiplication

Now we come to one of the condition numbers of fundamental importance in numerical linear algebra.

Fix $A in CC^(m times n)$ and consider the problem of computing $A x$ from input $x$; that is, we are going to determine a condition number corresponding to perturbations of $x$ but not $A$. Working directly from the definition of $K$, with $norm(dot)$ denoting an arbitrary vector norm and the corresponding induced matrix norm, we have:
$
  K=sup_(delta x) (norm(A(x+delta x)-A x) / norm(A x)) slash (
    norm(delta x) / norm(x)
  ) = sup_(delta x) norm(A delta x) / norm(delta x) slash norm(A x) / norm(x)
$
that is,
$
  K=norm(A) norm(x) / norm(A x)
$ <conditionnumberAx>
This is an exact formula for $K$, dependent on both $A$ and $x$.

Suppose $A$ is square and nonsingular. Then we can use the fact that $norm(x) slash norm(A x) lt.eq norm(A^(-1))$ to loosen @conditionnumberAx to a bound independent of $x$:
$ K lt.eq norm(A) norm(A^(-1)) $
Or, one might write this as:
$
  k = alpha norm(A) norm(A^(-1))
$
with
$
  alpha = norm(x) / norm(A x) slash norm(A^(-1))
$
If $norm(dot)=norm(dot)_2$ this will occur whenever $x$ is a multiple of a minimal right singular vector of $A$.

=== Condition number of a Matrix
The product $norm(A) norm(A^(-1))$ comes up so often that it has its own name: it is the _condition number_ of $A$:
$ K(A) = norm(A) norm(A^(-1)) $

Thus, in this case the term _condition number_ is attached to a matrix, not a problem. If $K(A)$ is small, $A$ is said to be _well-conditioned_; if it is large, $A$ is _ill-conditioned_. If $A$ is singular, it is customary to write $K(A) = infinity$.

Note that if $norm(dot)=norm(dot)^2$, then $norm(A)=sigma_1$ and $A^(-1)=1 / sigma_m$. Thus
$ K(A) = sigma_1 / sigma_m $
In the 2-norm, and it is this formula that is generally used for computing 2-norm condition numbers of matrices.

For a rectangular matrix $A in CC^(m times n)$ of full rank, $m gt.eq n$, the condition numver is defined in terms of the *pseudoinverse*: $K(A)=norm(A) norm(A^+)$. Since $A^+$ is motivated by least squares problems, this definition is most useful in the case $norm(dot)=norm(dot)^2$, where we have
$ K(A) = sigma_1 / sigma_n $

=== Condition Number of a System of Equations
Specifically, let us hold $b$ fixed and consider the behavior of the problem $A arrow x = A^(-1)b$ when $A$ is perturbed by infinitesimal $delta A$. Then $x$ must change by infinitesimal $delta x$ such that:
$ (A+delta A)(x + delta x)=0 $
Using the equality $A x=b$ and dropping the doubly infinitesimal term $(delta A)(delta x)$, we obtain $(sigma A)x + A(sigma)x=0$. that is, $sigma x = -A^(-1)(sigma A)x$. This equation implies $norm(sigma x) lt.eq norm(A^(-1)) norm(sigma A) norm(x)$, or equivalently:
$
  (sigma x) / norm(x) slash (sigma A) / norm(A) lt.eq norm(A^(-1)) norm(A) = K(A)
$
#theorem[
  Let b be fixed and consider the problem of computing $x=A^(-1)b$, where $A$ is square and nonsingular. The condition number of this problem with respect to perturbations in $A$ is
  $ K(A) = norm(A) norm(A^(-1)) $
]
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

= Sparse matrices

== Sparse matrices storage formats

Sparse matrices are matrices that contain a large number of zero elements. The storage of these matrices can be optimized by using different formats. The most common formats are:

=== Coordinate format (COO)

The simplest storage scheme for sparse matrices is the so-called coordinate format. The data structure consists of three arrays:
+ `AA` - all the values of the nonzero elements of $A$ in any order.
+ `JR` - the row indices of the nonzero elements of $A$.
+ `JC` - the column indices of the nonzero elements of $A$.

#example("Coordinate format")[
  #image("../figures/coo.png")
]

=== Compressed sparse row (CSR)

The CSR format is similar to COO, where the row indices are compressed and replaced by an array of offsets. The new data structure consists of three arrays:

+ `AA` - the real values $a_(i\j)$ sorted row by row, from row 1 to row $n$.
+ `JA` - the column indices of the nonzero elements of $A$.
+ `IA` - the row offsets. contains the pointers to the beginning of each row in the array $A$ and $\JA$. The content of $I\A$ is the position in the arrays $A\A$ and $J\A$ where the row $i$ starts. The length of $I\A$ is $n+1$, with $I\A(n+1)$ containing the total number of nonzero elements in the matrix.

#example("Compressed sparse row format")[
  #image("../figures/csr.png")
]

To create a sparse matrix in the CSR format, we use the `csr_matrix` function, which is provided by the `scipy.sparse` module. Here is an example program:

#sourcecode[
  ```python
    import scipy.sparse as sp
    from scipy import *

    data = [1.0, 2.0, -1.0, 6.6, 1.4]
    rows = [0, 1, 1, 3, 3]
    cols = [1, 1, 2, 0, 4]

    A = sp.csr_matrix((data, [rows, cols]), shape=(4, 5))
    print(A)

    >>> A.data
    array([ 1. ,  2. , -1. ,  6.6,  1.4])
    >>> A.indices
    array([1, 1, 2, 0, 4], dtype=int32)
    >>> A.indptr
    array([0, 1, 3, 3, 5], dtype=int32)
  ```]

#pagebreak()

#import "../template.typ": *

= Iterative methods for large linear systems

Given an $n times n$ real matrix $A$ and a real $n$-vector, the problem is: Find $x$ belonging to $R^n$ such that

$ A\x = b $ <problem1>

where $bold(x)$ is the exact solution of the linear system $A bold(x) = bold(b)$.

== On the Convergence of Iterative Methods

The basic idea of iterative methods is to construct a sequence of vectors $bold(x^k)$ that enjoy the property of _convergence_

$ bold(x)=lim_(k arrow infinity) bold(x^k) $ <convergence>

In practice, the iterative process is stopped at the minimum value of $n$ such that $bold(norm(x^((n))-x)) < epsilon$, where $epsilon$ is a given tolerance and $bold(norm(dot))$ is a suitable norm. However, since the exact solution is obviously not available, it is necessary to introduce suitable stopping criteria to monitor the convergence of the iteration.

To start with, we consider iterative methods of the form

$ text("Given") bold(x)^0, bold(x)^(k+1)=B bold(x^k) + bold(f), k #sym.gt.eq 0 $ <IterativeMethod>

where $B$ is an $n times n$ square matrix called the _iteration matrix_ and $bold(f)$ is a vector that is obtained from the right-hand side $bold(b)$.

having denoted by $B$ an $n × n$ square matrix called the iteration matrix and by $bold(f)$ a vector that is obtained from the right hand side $bold(b)$.

#definition[
  An iterative method of the form @IterativeMethod is said to be _convergent_ with @convergence if $bold(f)$ and $B$ are such that $bold(x)=bold(B\x)+bold(f)$. Equivalently,

  $ bold(f)=(1-B)A^(-1) bold(b) $
]

Having denoted by

$ bold(e)^((k)) = bold(x)^((k)) - bold(x) $ <error>

the error at the k-th step of the iteration, the condition for convergence amounts to requiring that $lim_(k arrow infinity) bold(e^k)=0$ for any choice of the initial datum $bold(x)^0$.

#theorem[
  Let @IterativeMethod be a consistent method. Then, the sequence of vectors ${x^(k)}$ converges to the solution of @problem1 for any choice of $x^((0)) "iff" rho(B) < 1$.\
  *Proof*. From @error and the consistency assumption, the recursive relation $bold(e)^(k+1)=B\e^(k)$ is obtained. Therefore,
  $
    e^((k))=B^k e^((0)), forall k=0,1, dots
  $
  Thus, thanks to Theorem 1.5, it follows that $lim_(k arrow infinity) B^k e^0=0$ for any $e^((0)) "iff" rho(B) < 1$.
]

#definition[
  Let $B$ be the iteration matrix. We call:
  + $norm(B^m)$ the _convergence factor_ after m steps of the iteration.
  + $norm(B)^(1 slash m)$ the _average convergence_ factor after m steps;
  + $R_m(B)=-1/ m log norm(B^m)$ the _average convergence rate_ after m steps.
]

== Linear Iterative Methods

A general technique to devise consistent linear iterative methods is based on an additive splitting of the matrix $A$ of the form $A=P−N$, where $P$ and $N$ are two suitable matrices and $P$ is nonsingular. For reasons that will be clear in the later sections, $P$ is called _preconditioning matrix or preconditioner_.

Precisely, given $x^((0))$, one can compute $x^((k))$ for $k gt.eq.slant$, solving the system:

$ P x^((k+1)) = N x^((k)) + b $ <LinearIterativeMethod>

The iteration matrix of method @LinearIterativeMethod is $B=P^(-1)N$ and the vector $f=P^(-1)b$. Alternatively, the method can be written as:

$ x^((k+1)) = x^((k)) + P^(-1) r^((k)) $ <LinearIterativeMethod2>

where the residual $r^((k))=b-A x^((k))$ is the vector that measures the error in the approximation $x^((k))$. @LinearIterativeMethod2 outlines the fact that a linear system, with coeﬃcient matrix $P$, must be solved to update the solution at step $k +1$. Thus $P$, besides being nonsingular, ought to be easily invertible, in order to keep the overall computational cost low.

=== Jacobi, Gauss-Seidel and Relaxation Methods

#heading(
  level: 4,
  outlined: false,
  "Jacobi Method and Over-Relaxation",
)

If the diagonal entries of $A$ are nonzero, we can single out in each equation the corresponding unknown, obtaining the equivalent linear system.

$
  x_i = (b_i - sum_(j=1 \ j eq.not i)^(n) a_(i\j) x_j) / a_(i\i), i=1, dots, n
$

In the Jacobi method, once an arbitrarily initial guess $x^((0))$ is given, the solution is updated by the formula:

$ x_i^((k+1)) = (b_i - sum_(j=1 \ j eq.not i)^(n) a_(i\j) x_j^((k))) / a_(i\i), i=1, dots, n $ <JacobiMethod>

This amounts to performing the following splitting for A:

#align(center)[
  $P = D, N = D− A = E + F$
]

where $D$ is the diagonal matrix of the diagonal entries of $A$, $E$ is the lower triangular matrix, and $F$ is the upper triangular matrix:

#figure(
  image("../figures/partition1.jpg", height: 20%),
)

The iteration matrix of the Jacobi method is thus given by

$ B_j = D^(-1) (E + F) = I - D^(-1) A $

A generalization of the Jacobi method is the over-relaxation method(or JOR), in which, having introduced a relaxation parameter $omega$, @JacobiMethod is replaced by:

$
  x_i^((k+1)) = (1 - omega) x_i^((k)) + omega (b_i - sum_(j=1 \ j eq.not i)^(n) a_(i\j) x_j^((
    k
  ))) / a_(i\i), i=1, dots, n
$ <OverRelaxationMethod>

The corresponding iteration matrix is:

$ B_(j_w)=omega B_j + (1-omega)I $

This method is consistent if any $omega eq.not 0$ and for $omega=1$ it coincides with the Jacobi method.

#heading(
  level: 4,
  outlined: false,
  "The Gauss Seidel method",
)

#import "../template.typ": *

= Numerical methods for overdetermined linear systems of equations

