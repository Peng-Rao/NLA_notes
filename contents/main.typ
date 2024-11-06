#import "../template.typ": *
#import "@preview/codelst:2.0.1": sourcecode
#import "@preview/lovelace:0.3.0": *

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

= Matrix Decompositions and Factorization
== QR Factorization
Let $A in RR(m times n)$ be a rectangular matrix, then
$ A = Q R $ <QRFactorization>
where $Q in RR(m times m)$ is an orthogonal matrix and $R in RR(m times n)$ is an upper trapezoidal matrix.

One version of the $Q R$ factorization is _reduced $Q R$ factorization_. Let $A$ be an $m times n$ matrix. The reduced $Q R$ factorization of $A$ is a factorization of the form:
$ A = hat(Q) hat(R) $ <ReducedQRFactorization>
where $Q in RR(m times n)$ is an rectangular matrix and $R in RR(n times n)$ is an upper triangular matrix.

== Cholesky Factorization
Let $A in RR^(n times n)$ be a _symmetric and positive definite_ (SPD) matrix. Then, there exists a unique upper triangular matrix $R in RR^(n times n)$ with positive diagonal
entries such that:
$ A = R^T R $ <CholeskyFactorization>
This factorization is called _Cholesky factorization_.
#align(center)[
  #pseudocode-list(line-numbering: none, booktabs: true, title: smallcaps[Cholesky Factorization], line-gap: 1.5em)[
    + Let $r_11=sqrt(a_11)$.
    + *For* $k=2, dots$
      + $r_(i j) = 1 / r_(i i)(a_(i j)- sum_(k=1)^(i-1)r_(k i) r_(k j))$
      + $r_(i i) = sqrt(a_(i i)- sum_(k=1)^(i-1)r_(k i)^2)$
  ]
]
The computational cost of the Cholesky factorization is $O(n^3 slash 3)$.

== Schur Decomposition
If $A in CC^(n times n)$ then there is a unitary matrix $U in CC^(n times n)$ such that:
$ U^H A U = T $ <SchurDecomposition>
where $T$ is an upper triangular matrix. The diagonal elements of $T$ are the eigenvalues of $A$. $U = [bold(u)_1, dots, bold(u)_n]$ are called Schur vectors. They are generally not the eigenvectors of $A$.

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

  $ |(x,y)| lt.eq norm(x)_p norm(y) _q #h(1cm) "Where" #h(1cm) 1/p + 1/q = 1 $
]

#theorem("Norm continuity")[
  Any vector norm $norm(dot)$ defined on V is a continous function of its argument, namely, $forall > 0, exists C > 0$ such that if $norm(x-hat(x)) lt.eq epsilon$ then $norm(x)-norm(hat(x)) lt.eq C epsilon$, for any $x, hat(x) in V$.
]

#theorem[
  let $norm(dot)$ be a norm of $RR^n$ and $A in RR^(n times n)$ be a matrix with n linearly independent columns. Then, the function $norm(dot)_(A^2)$ acting from $RR^n$ in to $RR$ defined as:

  $ norm(x)_(A^2) = norm(A\x) $

  is a norm on $RR^n$.
]

#theorem("Energy Norm")[
  Let $A in RR^(n times n)$ is a symmetric positive definite matrix. Then, the _energy norm_ is defined as:
  $ norm(x)_A = sqrt(bold(x)^T A bold(x)) $
] <energynorm>

#theorem("Convergence")[
  Let $norm(dot)$ be a norm in a finite dimensional space V. Then:
  $
    lim_(k arrow infinity) x^((k))=x arrow.l.r.double.long lim_(k arrow infinity) norm(x^((k))-x)=0
  $
  where $x in V$ and $x^((k))$ is a sequence of vectors in V.
]

== Matrix Norms
In dealing with a space of matrices, certain special norms are more useful thant the vector norms. These are the _induced matrix norms_, defined in terms of the behavior of a matrix as an operator between its normed domain and range spaces.

#definition("Matrix Norm")[
  A _matrix norm_ is a mapping $norm(dot): RR^(m times n) arrow RR$ such that:

  #block[
    + $norm(A) gt.eq 0 forall A in RR^(m times n) "and" norm(A)=0$ if and only if $A=0$.
    + $norm(alpha A) = |alpha| norm(A) forall A in RR^(m times n) "and" alpha in CC$.
    + $norm(A+B) lt.eq norm(A) + norm(B) forall A, B in RR^(m times n)$(triangular inequality)
  ]
] <matrixnorm>

#definition[
  We say that a matrix norm $norm(dot)$ is _compatible_ or _consistent_ with a vector norm $norm(dot)$ if:
  $
    norm(A\x) lt.eq norm(A) norm(x) #h(1cm) forall x in RR^n
  $
  More generally, given three norms, all denoted by $norm(dot)$, albeit defined on $RR^m, RR^n. RR^(m times n)$, respectively, we say that they are consistent if if $forall x in RR^n, A\x=y in RR^m$, we have that $norm(y) lt.eq norm(A) norm(x)$.
]

#definition("Sub multiplicative")[
  We say that a matrix norm $norm(dot)$ is _sub-multiplicative_ if $forall A in RR^(n times m), forall B in RR^(m times q)$ we have that $
  norm(A\B) lt.eq norm(A) norm(B) $
]

#definition("Fronebius Norm")[
  The norm
  $
    norm(A)_F = sqrt(sum_(i=1)^m sum_(j=1)^n |a_(i\j)|^2)=sqrt(tr(A A^H))
  $
  is a matrix norm called the _Frobenius norm_. And it is compatible with the Euclidean vector norm $norm(dot)_2$. Indeed.
  $
    norm(A\x)_2^2=sum_(i=1)^m |sum_(j=1)^n a_(i\j) x_j|^2 lt.eq sum_(i=1)^m sum_(j=1)^n |a_(i\j)|^2 sum_(j=1)^n |x_j|^2=norm(A)_F^2 norm(x)_2^2
  $
]

#theorem("Induced Matrix Norm")[
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
  \ *Proof*： Since $A^T A$ is hermitian, there exists a unitary matrix $U$ such that $ U^H A^H A U = "diag"(mu_1, dots, mu_n) $
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
== Sequences and Series of Matrices
A sequence of matrices $A^(k)$ is said to _converge_ to a matrix $A in RR^(n times n)$ if
$ lim_(k arrow infinity) norm(A^(k)-A) = 0 $ <matrix_convergence>
The choice of the norm does not influence the result since in $RR^(n times n)$ all norms are equivalent.

#theorem("Convergence of Sequences of Matrices")[
  Let $A$ be a square matrix; then
  $ lim_(k arrow infinity) A^(k) = 0 arrow.l.r.double rho(A) < 1 $
] <convergence_matrix>

#pagebreak()
= Principles of Numerical Mathematics
== Well-posedness and Condition Number
Consider the following problem: find $x$ such that:

$ F(x,d) = 0 $ <1>

where $F$ is a function of $x$ and $d$. And three types of problems can be considered:
+ _direct problem_: given $F$ and $d$, find $x$;
+ _inverse problem_: given $F$ and $x$, find $d$;
+ _identification problem_: given $x$ and $d$, find $F$.

Problems @1 are *_well-posed_* if it admits a _unique_ solution, and the solution depends continuously on the data.

A problem which does not enjoy the property above is called ill posed or unstable and before undertaking its numerical solution it has to be regularized, that is, it must be suitably transformed into a well-posed problem.

Let $D$ be the set of admissible data, i.e. the set of the values of $d$ in correspondance of which problem @1 admits a unique solution. Continuous dependence on the data means that small perturbations on the data d of $D$ yield “small” changes in the solution $x$.

Precisely, let $d in D$ and denoted by $delta d$ a perturbation admissible in the sense that $d + delta d in D$ and by $delta x$ the corresponding change in the solution, in such a way that:

$ F(x + delta x, d + delta d) = 0 $ <2>

Then, we require that:

$
  exists eta_0 = eta_0(d) > 0, exists K_0=K_0(
    d
  ) text("such that") \ text("if") norm(delta d) lt.eq.slant eta_0 text("then") norm(delta x) lt.eq.slant K_0 norm(delta d)
$ <3>

The norms used for the data and for the solution may not coincide, whenever $d$ and $x$ represent variables of diﬀerent kinds.

#example("Wellposedness of Linear Systems")[
  Consider the problem of solving a linear system $A x = b$. The problem is well-posed if it has below two properties:
  + The problem has a unique solution $x$, which means that the matrix $A$ is invertible.
  + The solution depends continously on the data.
]

The @3 is however more suitable to express in the following the concept of _numerical stability_, that is, the property that small perturbations on the data yield perturbations of the same order on the solution.

=== Absolute Condition Number
Let $delta x$ denote a small perturbation of $x$, and wirte $delta f = f(x + delta x, d) - f(x, d)$. The absolute condition number is then defined as:
$ K_("abs")=lim_(delta arrow 0) sup_(norm(delta x) lt.eq delta) norm(delta f) / norm(delta x) $
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
#pagebreak()
= Sparse matrices
== Sparse matrices storage formats
Sparse matrices are matrices that contain a large number of zero elements. The storage of these matrices can be optimized by using different formats. The most common formats are:

=== Coordinate format (COO)
The simplest storage scheme for sparse matrices is the so-called coordinate format. The data structure consists of three arrays:
+ `AA` - all the values of the nonzero elements of $A$ in any order.
+ `JR` - the row indices of the nonzero elements of $A$.
+ `JC` - the column indices of the nonzero elements of $A$.

#example("Coordinate format")[
  #image("../figures/coo.png", height: auto)
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
Given an $n times n$ real matrix $A$ and a real $n$-vector, the problem is: Find $bold(x)$ belonging to $RR^n$ such that

$ A bold(x) = bold(b) $ <problem1>

where $bold(x)$ is the exact solution of the linear system $A bold(x) = bold(b)$. In such cases existence and uniqueness of the solution are ensured if one of the following (equivalent) hypotheses holds:
+ $A$ is invertible
+ rank($A$)=n;
+ the homogeneous system $A bold(x)=0$ admits only the null solution.

== On the Convergence of Iterative Methods
The basic idea of iterative methods is to construct a sequence of vectors $bold(x^k)$ that enjoy the property of _convergence_

$ bold(x)=lim_(k arrow infinity) bold(x^k) $ <convergence>

In practice, the iterative process is stopped at the minimum value of $n$ such that $bold(norm(x^((n))-x)) < epsilon$, where $epsilon$ is a given tolerance and $bold(norm(dot))$ is a suitable norm. However, since the exact solution is obviously not available, it is necessary to introduce suitable stopping criteria to monitor the convergence of the iteration.

To start with, we consider iterative methods of the form

$ text("Given") bold(x)^0, bold(x)^(k+1)=B bold(x^k) + bold(f), k #sym.gt.eq 0 $ <IterativeMethod>

where $B$ is an $n times n$ square matrix called the _iteration matrix_ and $bold(f)$ is a vector that is obtained from the right-hand side $bold(b)$.

having denoted by $B$ an $n × n$ square matrix called the iteration matrix and by $bold(f)$ a vector that is obtained from the right hand side $bold(b)$.

#definition("Consistent")[
  An iterative method of the form @IterativeMethod is said to be _consistent_ with @problem1 if $bold(f)$ and $B$ are such that $bold(x)=bold(B\x)+bold(f)$. Equivalently,

  $ bold(f)=(1-B)A^(-1) bold(b) $

  Having denoted by

  $ bold(e)^((k)) = bold(x)^((k)) - bold(x) $ <error>

  the error at the k-th step of the iteration, the condition for convergence amounts to requiring that $lim_(k arrow infinity) norm(bold(e^k))=0$ for any choice of the initial datum $bold(x)^0$.

  Consistency alone does not suﬃce to ensure the convergence of the iterative method @IterativeMethod.
]



#theorem("Convergence of Iterative method")[
  Let @IterativeMethod be a consistent method. Then, the sequence of vectors ${x^(k)}$ converges to the solution of @problem1 for any choice of $x^((0)) "iff" rho(B) < 1$.\
  *Proof*. From @error and the consistency assumption, the recursive relation $bold(e)^(k+1)=B\e^(k)$ is obtained:
  $
    bold(e)^(k+1)= x^(k+1) - x^(k)= B x^(k)+f - (B x+f) =B e^(k)
  $
  Therefore,
  $
    e^((k))=B^k e^((0)), forall k=0,1, dots
  $
  Thus, thanks to @convergence_matrix, it follows that $lim_(k arrow infinity) B^k e^0=0$ for any $e^((0)) "iff" rho(B) < 1$.
]

#definition[
  Let $B$ be the iteration matrix. We call:
  + $norm(B^m)$ the _convergence factor_ after m steps of the iteration.
  + $norm(B)^(1 slash m)$ the _average convergence_ factor after m steps;
  + $R_m(B)=-1/ m log norm(B^m)$ the _average convergence rate_ after m steps.
]

== Stopping Criteria
The convergence of an iterative method is monitored by means of a stopping criterion. We can easily introduce the following criteria:
$
  norm(bold(x)-bold(x^((k)))) / norm(bold(x^((k)))) lt.eq epsilon
$
Unfortunately, the exact solution $bold(x)$ is not known, we are trying to convert the problem into a residual-based stopping criterion.
\ *Residual-base stopping criteria*: The iteration is stopped when the residual $bold(r^((k)))=bold(b)-A bold(x^((k)))$ is small enough:
$
  norm(bold(x)-bold(x^((k)))) / norm(bold(x^((k)))) lt.eq K(
    A
  ) norm(bold(r^((k)))) / norm(bold(b)) arrow.r.double.long norm(bold(r^((k)))) / norm(bold(b)) lt.eq epsilon
$
This is a good criteria whenever the condition number $K(A)$ is not too large. If the condition number is large, the residual-based stopping criterion may be too stringent. To make the constant $K(A)$ smaller in the stopping criterion, there is a method called _preconditioning_:
$
  norm(bold(x)-bold(x^((k)))) / norm(bold(x^((k)))) lt.eq K(
    P^(-1) A
  ) norm(z^((k))) / norm(bold(b)) arrow.r.double.long norm(z^((k))) / norm(bold(b)) lt.eq epsilon
$
where $z^((k))= P^(-1) bold(r)^k$.

\ *Distance between consecutive iterations*: The iteration is stopped when the distance between consecutive iterates is small enough, define the distance $bold(delta)^((k))=bold(x)^((k+1))-bold(x)^((k))$, then the stopping criterion is:
$
  norm(bold(delta)^((k))) lt.eq epsilon
$
The relation between the true error and the distance between consecutive iterates is given by:
$
  norm(bold(e)^((k))) lt.eq norm(bold(delta)^((k))) / (1-rho(B))
$
Therefore this is a “good” stopping criterion only if $rho(B) << 1$.

== Linear Iterative Methods
A general technique to devise consistent linear iterative methods is based on an additive splitting of the matrix $A$ of the form $A=P−N$, where $P$ and $N$ are two suitable matrices and $P$ is nonsingular. For reasons that will be clear in the later sections, $P$ is called _preconditioning matrix or preconditioner_.

Precisely, given $x^((0))$, one can compute $x^((k))$ for $k gt.eq.slant$, solving the system:

$ P x^((k+1)) = N x^((k)) + b $ <LinearIterativeMethod>

The iteration matrix of method @LinearIterativeMethod is $B=P^(-1)N$ and the vector $f=P^(-1)b$. Alternatively, the method can be written as:

$ x^((k+1)) = x^((k)) + P^(-1) r^((k)) $ <LinearIterativeMethod2>

where the residual $ r^((k))=b-A x^((k)) $ is the vector that measures the error in the approximation $x^((k))$. @LinearIterativeMethod2 outlines the fact that a linear system, with coeﬃcient matrix $P$, must be solved to update the solution at step $k +1$. Thus $P$, besides being nonsingular, ought to be easily invertible, in order to keep the overall computational cost low.(Notice that, if $P$ were equal to $A$ and $N=0$, method @LinearIterativeMethod2 would converge in one iteration, but at the same cost of a direct method.

Let us mention two results that ensure convergence of the iteration @LinearIterativeMethod2, provided suitable conditions on the splitting of A are fulfilled.

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
The Gauss-Seidel method diﬀers from the Jacobi method in the fact that at the $k+1$th step the available values of $x_i^((k+1))$ are being used to update the solution:
$
  x_i^((k+1))= (b_i - sum_(j=1)^(i-1) a_(i\j) x_j^((k+1)) - sum_(j=i+1)^(n) a_(i\j) x_j^((k))) / a_(i\i), i=1, dots, n
$
This method amounts to performing the following splitting for $A$:
$
  P = D - E, N = F
$
and the iteration matrix is:
$
  B_(G S) = (D - E)^(-1) F
$

== Stationary and Nonstationary Iterative Methods
Devoted by
$
  R_p = I - P^(-1) A
$
the iteration matrix associated with @LinearIterativeMethod2. Proceeding as in the case of relaxation methods, @LinearIterativeMethod2 can be generalized introducing a relaxation (or acceleration) parameter $alpha$. This leads to the following _stationary Richardson method_.
$
  bold(x)^((k+1)) = bold(x)^((k)) + alpha P^(-1) bold(r)^((k)), k gt.eq 0
$
More generally, allowing $alpha$ to depend on the iteration index, _the nonstationary Richardson method or semi-iterative method_ is given by
$
  bold(x)^((k+1)) = bold(x)^((k)) + alpha^((k)) P^(-1) bold(r)^((k)), k gt.eq 0
$ <NonstationaryRichardsonMethod>
The iteration matrix at the k-th step for @NonstationaryRichardsonMethod is
$
  B_(R) = I - alpha_k P^(-1) A
$
with $alpha_k=alpha$ in the stationary case. If $P = I$, the family of methods @NonstationaryRichardsonMethod will be called _nonpreconditioned_.The Jacobi and Gauss-Seidel methods can be regarded as stationary Richardson methods with $P = D$ and $P = D- E$, respectively.

We can rewrite @NonstationaryRichardsonMethod in a form of greater interest for computation. Letting $bold(z)^((k))=P^(-1) bold(r)^((k))$(the so-called _preconditioned residual_), we have $bold(x)^((k+1))=bold(x)^((k))+alpha_k bold(z)^((k))$ and $bold(r)^((k+1))=bold(r)^((k))-alpha_k A bold(z)^((k))$.

To summarize, a nonstationary Richardson method requires at each $k+1$th step the following operations:
+ solve the linear system $P bold(z)^((k))=bold(r)^((k))$
+ compute the acceleration parameter $alpha_k$
+ update the solution $bold(x)^((k+1))=bold(x)^((k))+alpha_k bold(z)^((k))$
+ update the residual $bold(r)^((k+1))=bold(r)^((k))-alpha_k A bold(z)^((k))$
#theorem("Convergence")[
  Assume that P is a nonsingular matrix and that $P^(-1)A$ has positive real eigenvalues, ordered in such a way that $lambda_1 gt.eq lambda_2 gt.eq dots gt.eq lambda_n gt 0$. Then, the stationary Richardson method converges if and only if $0 lt.eq alpha lt.eq 2 / lambda_1$. Moreover, letting
  $
    alpha_("opt") = 2 / (lambda_1 + lambda_n)
  $
  the spectral radius of the iteration matrix $R_alpha$ is minimum if $alpha=alpha_("opt")$, with
  $
    rho_("opt") = min_{alpha} rho(R_alpha) = (lambda_1 - lambda_n) / (lambda_1 + lambda_n)
  $
]
#example("Preconditioned Stational Richardson Method")[
  #pseudocode-list(
    line-numbering: none,
    booktabs: true,
    line-gap: 1em,
    title: smallcaps[Preconditioned Stational Richardson Method],
  )[
    + Given arbitrary $bold(x)^0=$, Let $bold(r)^0=bold(b)-A bold(x)^0$
    + *For* $k=0,1, dots$
      + Compute $alpha_("opt")=2 / (lambda_min (P^(-1)A) + lambda_max (P^(-1)A))$
      + Solve the linear system $P bold(z)^((k))=bold(r)^((k))$
      + Update the solution: $bold(x)^((k+1))=bold(x)^((k))+alpha_("opt") bold(z)^((k))$
      + Update the residual: $bold(r)^((k+1))=bold(r)^((k))-alpha_("opt") A bold(z)^((k))$
  ]
]

=== Preconditioning Matrices
All the methods introduced in the previous sections can be cast in the form @IterativeMethod , so that they can be regarded as being methods for solving the system
$
  (I-B) bold(x)=bold(f)=P^(-1) bold(b)
$
On the other hand, since $B=P^(-1)N$, linear system $A bold(x) =bold(b)$ can be equivalently rewrited as
$
  P^(-1) A bold(x)=P^(-1) bold(b)
$
The latter is the preconditioned system, being $P$ the preconditioning matrix or left preconditioner. Right and centered preconditioners can be introduced as well,
$
  A P^(-1) bold(y)=bold(b), bold(y)=P bold(x)
$
or
$
  P^(-1)_L A P^(-1)_R bold(y)=P^(-1)_L bold(b), bold(y)=P_R bold(x)
$
There are _point preconditioners_ and _block preconditioners_, depending on whether they are applied to the single entries of $A$ or to the blocks of a partition of $A$. The iterative methods considered so far correspond to fixed-point iterations on a left-preconditioner system. Computing the inverse of $P$ is not mandatory; actually, the role of P is to "precondition" the residual $bold(r)^((k))$.

Since the preconditioner acts on the spectral radius of the iteration matrix, it would be useful to pick up, for a given linear system, an _optimal preconditioner_, a preconditioner which is able to make the number of iterations required for convergence independent of the size of the system.

There is not a general roadmap to devise optimal preconditioners. However, an established "rule of thumb" is that $P$ is a good preconditioner for $A$ if $P^(-1) A$ is near to being a normal matrix and if its eigenvalues are clustered within a sufficiently samll region of the complex field. The choice of a preconditioner must also be guided by practical considerations, noticeably, its computational cost and its memory requirements.

Preconditioners can be divided into two main categories: algebraic and functional preconditioners, the diﬀerence being that the algebraic preconditioners are independent of the problem that originated the system to be solved, and are actually constructed via algebraic procedures, while the functional preconditioners take advantage of the knowledge of the problem and are constructed as a function of it.

=== The Gradient Method
In the special case of symmetric and positive definite matrices, however, the optimal acceleration parameter can be dynamically computed at each step $k$ as follows.

We first notice that, for such matrices, solving system @LinearIterativeMethod2 is equivalent to minimizing the quadratic form
$
  Phi(bold(y))=1 / 2 bold(y)^T A bold(y) - bold(y)^T b
$
which is called the _energy of system_, Indeed, the gradient of $Phi$ is given by
$
  nabla Phi(bold(y))= 1 / 2 (A + A^T) bold(y) - bold(b) = A bold(y) - bold(b)
$ <gradient>
As a consequence, if $nabla Phi(bold(x))=0$, then $bold(x)$ is a solution of the original system. Conversely, if $bold(x)$ is a solution, then
$
  Phi(bold(y)) = Phi(bold(x) + bold(y-x))=Phi(bold(x)) + 1 / 2 (bold(y-x))^T A (bold(y-x))
$
and thus, for any $bold(y)$, the value of $Phi$ is minimized at $bold(x)$.
Notice that the previous relation is equivalent to
$
  1 / 2 norm(bold(y-x))^2_A = Phi(bold(y)) - Phi(bold(x))
$
where $norm(bold(dot))_A$ is the energy norm, defined in @energynorm.

The problem is thus to determine the minimizer $bold(x)$ of $Phi$ by starting from a point $bold(x)^0$, and, consequently, to select suitable directions along which moving to get as close as possible to the solution $bold(x)$. The optimal direction, that joins the starting point $bold(x)^((0))$ to the solution point $bold(x)$, is obviously unknown a priori. Therefore, we must take a step from $bold(x)^((0))$ along a given direction $bold(p)_0$ and then fix along this latter a new point $bold(x)^((1))$ from which to iterate the process until convergence.

Precisely, at the generic step $k$, $bold(x)^((k+1))$ is computed as
$
  bold(x)^((k+1)) = bold(x)^((k)) + alpha_k bold(p)^((k))
$
where $alpha_k$ is the value which fixes the length of the step along the direction $bold(p)^((k))$.

The most natural idea is to take as $bold(p)^((k))$ the direction of maximum descent along the functional $Phi$ in $bold(x)^((k))$, which is given by $-nabla Phi(bold(x)^((k)))$. This yields the gradient method, also called steepest descent method.

Due to @gradient, $nabla Phi(bold(x)^((k)))=A bold(x)^((k))-bold(b)=-bold(r)^((k))$ so that the direction of the gradient of $Phi$ coincides with the residual $bold(r)^((k))$. So it can be immediately computed using the current iterate. This shows that the gradient method, as well as the nonstationary Richardson method with $P=I$, moves at each step $k$ along the direction of the residual $bold(r)^((k))$.

To compute the parameter $alpha^((k))$ let us write explicitly $Phi(bold(x)^((k+1)))$ as a function of a parameter $alpha$
$
  Phi(bold(x)^((k+1))) = 1 / 2 (bold(x)^((k)) + alpha bold(r)^((k)))^T A (bold(x)^((k)) + alpha bold(r)^((k))) - (
    bold(x)^((k)) + alpha bold(r)^((k))
  )^T bold(b)
$
Diﬀerentiating with respect to α and setting it equal to zero yields the desired value of $alpha_k$
$
  alpha_k = (bold(r)^(k)^T bold(r)^((k))) / (bold(r)^(k)^T A bold(r)^((k)))
$
#align(center)[
  #pseudocode-list(
    line-numbering: none,
    booktabs: true,
    line-gap: 1.3em,
    title: smallcaps[Gradient Method],
  )[
    + Given $bold(x)^((0))$, compute the residual: $bold(r)^((0))=bold(b)-A bold(x)^((0))$
    + *While*(Stopping criterion is not satisfied)
      + Compute parameter $alpha_k = (bold(r)^(k)^T bold(r)^((k))) / (bold(r)^(k)^T A bold(r)^((k)))$
      + Update the solution: $bold(x)^((k+1))=bold(x)^((k)) + alpha_k bold(r)^((k))$
      + Update the residual: $bold(r)^((k+1))=bold(r)^((k)) - alpha_k A bold(r)^((k))$
  ]
]
=== The Conjugate Gradient Method
The gradient method consists essentially of two phases: choosing a direction $bold(p)^((k))$ and picking up a point of local minimum for $Phi$ along that direction. The latter request can be accommodated by choosing $alpha_k$ as the value of the parameter $alpha$ such that $Phi(bold(x)^((k))+alpha bold(p)^((k)))$ is minimized. Diﬀerentiating with respect to $alpha$ and setting it equal to zero, we obtain the following expression for $alpha_k$:
$
  alpha_k = (bold(p)^(k)^T bold(r)^((k))) / (bold(p)^(k)^T A bold(p)^((k)))
$
#align(center)[
  #pseudocode-list(
    line-numbering: none,
    booktabs: true,
    line-gap: 1.5em,
    title: smallcaps[Conjugate Gradient Method],
  )[
    + Given $bold(x)^((0))$, compute $bold(r)^((0))=bold(b)-A bold(x)^((0)), bold(p)^((0))=bold(r)^((0))$
    + *While*(Stopping criterion is not satisfied)
      + Compute step lenght $alpha_k = (bold(p)^(k)^T bold(r)^((k))) / (bold(p)^(k)^T A bold(p)^((k)))$
      + Update the solution: $bold(x)^((k+1))=bold(x)^((k)) + alpha_k bold(p)^((k))$
      + Update the residual: $bold(r)^((k+1))=bold(r)^((k)) - alpha_k A bold(p)^((k))$
      + Compute the conjugate coefficient $beta_k = ((A bold(p)^((k)))^T bold(r)^((k+1))) / ((A bold(p)^((k)))^T bold(p)^((k)))$
      + Update the direction: $bold(p)^((k+1))=bold(r)^((k+1)) - beta_k bold(p)^((k))$
  ]
]

=== The Preconditioned Conjugate Gradient Method
If $P$ is a symmetric and positive definite matrix, the preconditioned conjugate gradient method(PCG) consists of applying the CG method to the preconditioned system:
$
  P^(-1 / 2) A P^(-1 / 2) bold(y)=P^(-1 / 2) bold(b), "with" bold(y)=P^(-1 / 2) bold(x)
$

#align(center)[
  #pseudocode-list(
    line-numbering: none,
    booktabs: true,
    line-gap: 1.5em,
    title: smallcaps[Preconditioned Conjugate Gradient Method],
  )[
    + Given $bold(x)^((0))$, compute $bold(r)^((0))=bold(b)-A bold(x)^((0)), bold(z)^((0))=P^(-1) bold(r)^((0)), bold(p)^((0))=bold(z)^((0))$
    + *While*(Stopping criterion is not satisfied)
      + Compute step length $alpha_k = (bold(p)^(k)^T bold(r)^((k))) / (bold(p)^(k)^T A bold(p)^((k)))$
      + Update the solution: $bold(x)^((k+1))=bold(x)^((k)) + alpha_k bold(p)^((k))$
      + Update the residual: $bold(r)^((k+1))=bold(r)^((k)) - alpha_k A bold(p)^((k))$
      + Solve the preconditioned system: $P bold(z)^((k+1))=bold(r)^((k+1))$
      + Compute the conjugate coefficient $beta_k = (bold(z)^(k+1)^T bold(r)^((k+1))) / (bold(z)^(k+1)^T bold(z)^((k)))$
      + Update the direction: $bold(p)^((k+1))=bold(z)^((k+1)) + beta_k bold(p)^((k))$
  ]
]
== Methods Based on Krylov Subspace Iterations
#definition("Krylov Subspace")[
  Given a nonsingular matrix $A in RR(n times n)$ and $bold(y) in RR^n$, $bold(y) eq.not bold(0)$, the $m$th Krylov subspace $K_m (A, bold(y))$ generated by $A$ and $bold(y)$ is
  $
    K_m (A, bold(y)) = "span" {bold(y), A bold(y), A^2 bold(y), dots, A^(m-1) bold(y)}
  $
]

Consider the Richardson method @NonstationaryRichardsonMethod with $P=I$; the residual at the $k$-th step can be related to the initial residual as
$
  bold(r)^((k))= product_(j=0)^(k-1) (I - alpha_j A) bold(r)^((0))
$ <kry_residual>
So start at $bold(r)^((k))=p_k A bold(r)^((0))$, where $p_k (A)$ is a polynomial in $A$ of degree $k$.

In an analogous manner as for @kry_residual, it is seen that the iterate $bold(x)^((k))$ of the Richardson method is given by
$
  bold(x)^((k)) = bold(x)^((0)) + sum_(j=0)^(k-1) alpha_j bold(r)^((j))
$
so that $bold(x)^((k))$ belongs to the following space
$
  W_k = {bold(v)=bold(x)^((0))+bold(y), bold(y) in K_k (A, bold(r)^((0)))}
$
In the nonpreconditioned Richardson method we are thus looking for an approximate solution to $bold(x)$ in the space $W_k$. More generally, we can think of devising methods that search for approximate solutions of the form
$
  bold(x)^((k)) = bold(x)^((0)) + q_(k-1) (A) bold(r)^((0))
$ <kry_solution>
where $q_(k-1)$ is polynomial selected in such a way that $bold(x)^((k))$ be, in a sense that must be made precise, the best approximation of $bold(x)$ in $W_k$. A method that looks for a solution of the form @kry_residual is called a _Krylov subspace method_.


#pagebreak()

= Solving large scale eigenvalue problems
== Eigenvalues and Eigenvectors
Given a square matrix $A in CC^(n times n)$, find a scalar $lambda$ and a nonzero vector $x in CC^n$ such that:
$ A x = lambda x $ <eigenproblem>
where:
+ The vector x is the _eigenvector_, And the scalar $lambda$ is the _eigenvalue_
+ The set of all the eigenvalues of a matrix $A$ is called the _spectrum_ of $A$, denoted by $sigma(A)$.
+ The maximum modulus of all the eigenvalues is called the _spectral radius_ of $A$ and is denoted by $rho(A) = max_{lambda in sigma(A)} |lambda|$.

*Remarks*
+ The eigenvalues of a matrix are the roots of the characteristic polynomial $det(A - lambda I) = 0$.
+ From the Fundamental Theorem of Algebra, an $n times n$ matrix has exactly $n$ eigenvalues, counting multiplicities.
+ Each $lambda_i$ may be real but in general is a complex number
+ The eigenvalues $lambda_1, lambda_2, dots, lambda_n$may not all have distinct values
+ Rayleigh quotient: $lambda_i = (x_i^H A x_i) / (x_i^H x_i)$

== The Power Method
Let $A in CC^(n times n)$ be a diagonalizable matrix and let $X in CC^(n times n)$ be the matrix of its eigenvectors $bold(x_i)$. for $i=1, dots, n$. Let us also suppose that the eigenvalues of $A$ are ordered as
$ |lambda_1| > |lambda_2| gt.eq dots gt.eq |lambda_n| $
Where $lambda_1$ has algebraic multiplicity equal to 1. Under these assumptions, $lambda_1$, is called the _dominant eigenvalue_ of $A$.

Given an arbitrary initial vector $bold(q)_0 in CC^n$ with unitary Euclidean norm, consider for $k=1,2, dots$ the following iteration based on the computation of powers of matrices, commonly known as the _power method_:
$
  bold(z)^((k)) =& A bold(q)^((k-1)) \
  bold(q)^((k)) =& bold(z)^((k)) / norm(bold(z)^((k))) \
  nu^((k)) =& bold(q)^((k))^H A bold(q)^((k))
$ <PowerMethod>
#align(center)[
  #pseudocode-list(line-numbering: none, booktabs: true, title: smallcaps[The Power Method])[
    + $bold(q)_0=$some initial vector with $norm(q_0)=1$
    + *For* $k=1,2, dots$
      + Apply $A$: $bold(z)^((k))=A bold(q)^((k-1))$ #h(1cm)
      + Normalize: $bold(q)^((k))=bold(z)^((k)) / norm(bold(z)^((k)))$ #h(1cm)
      + Compute Rayleigh quotient: $nu^((k))=bold(q)^((k))^H A bold(q)^((k))$ #h(1cm)
  ]
]

Let us analyze the convergence of the power method. By induction on $k$, we have that:
$
  bold(q)^((k)) =& A^k bold(q)^((0)) / norm(A^k bold(q)^((0))), k gt.eq 1
$
This relation explains the role played by the powers of $A$ in the method. Because $A$ is diagonalizable, its eigenvectors $bold(x)_i$ form a basis of $CC^n$ and we can write:
$
  bold(q)^((0)) = sum_(i=1)^n alpha_i bold(x)_i
$
Moreover, since $A bold(x)_i = lambda_i bold(x)_i$, we have:
$
  A^k bold(q)^((0)) =& sum_(i=1)^n alpha_i lambda_i^k bold(x)_i \
  =& alpha_1 lambda_1^k (bold(x)_1 + sum_(i=2)^n alpha_i / alpha_1 (lambda_i / lambda_1)^k bold(x)_i)
$
Since $abs(lambda_i / lambda_1) < 1$ for $i=2, dots , n$, as $k$ increases the term $sum_(i=2)^n alpha_i / alpha_1 (lambda_i / lambda_1)^k bold(x)_i$ tends to assume an increasingly significant component in the direction of the eigenvector $bold(x)_1$, while ts components in the other directions $bold(x)_j$ decrease.

As $k arrow infinity$, the vector $bold(q)^((k))$ thus aligns itself along the direction of eigenvector $bold(x)_1$, and the following error estimate holds at each step $k$.

#theorem("Convergence of the Power Method")[
  Let $A in CC^(n times n)$ be a diagonalizable matrix whose dominant eigenvalue is $lambda_1$. Assuming that $alpha_1 eq.not 0$, there exists a constant $C gt 0$ such that:
  $
    norm(bold(tilde(q))^((k)) - bold(x)_1) lt.eq C (|lambda_2 / lambda_1|)^k, k gt.eq 1
  $ <EstimatePowerMethod>
  where:
  $
    bold(tilde(q))^((k)) = bold(x)_1 + sum_(i=2)^n alpha_i / alpha_1 (lambda_i / lambda_1)^k bold(x)_i, k = 1,2, dots
  $
]
Estimate @EstimatePowerMethod expresses the convergence of the sequence of $bold(tilde(q))^((k))$ towards the eigenvector $bold(x)_1$ of $A$. Therefore the sequence of Rayleigh quotients
$
  bold(tilde(q))^((k))^H A bold(tilde(q))^((k)) slash norm(bold(tilde(q))^((k))) = (bold(q)^((k)))^H A bold(q)^((
    k
  ))= nu^((k))
$
will converge to the dominant eigenvalue $lambda_1$ of $A$. As a consequence, and the convergence will be faster when the ratio $|lambda_2 / lambda_1|$ is smaller.

== Deflation


== The Inverse Power Method
We look for an approximation of the eigenvalue of a matrix $A in CC^(n times n)$ which is _closest_ to a given number $mu in CC$, where $mu in.not sigma(A)$. For this, the power iteration is applied to the matrix $(M_mu)^(-1)=(A - mu I)^(-1)$, yielding the so-called _inverse iteration_ or _inverse power method_. The number $mu$ is called the _shift_ of the method.

The eigenvalues of $M_u^(-1)$ are $xi=(lambda_i - mu)^(-1)$, let us assume that there exists an integer m such that
$
  abs(lambda_m - mu) lt abs(lambda_i - mu)
$
Given an arbitrary initial vector $bold(q)_0 in CC^n$ with unitary Euclidean norm, for $k=1,2, dots$ the following sequence is constructed:
$
  (A - mu I) bold(z)^((k)) =& bold(q)^((k-1)) \
  bold(q)^((k)) =& bold(z)^((k)) / norm(bold(z)^((k))) \
  nu^((k)) =& bold(q)^((k))^H A bold(q)^((k))
$ <InversePowerMethod>
#align(center)[
  #pseudocode-list(line-numbering: none, booktabs: true, title: smallcaps[The Inverse Power Method])[
    + $bold(q)_0=$some initial vector with $norm(q_0)=1$
    + *For* $k=1,2, dots$
      + Solve linear equation $(A - mu I)$: $bold(z)^((k))=(A - mu I) bold(q)^((k-1))$ #h(1cm)
      + Normalize: $bold(q)^((k))=bold(z)^((k)) / norm(bold(z)^((k)))$ #h(1cm)
      + Compute Rayleigh quotient: $nu^((k))=bold(q)^((k))^H A bold(q)^((k))$ #h(1cm)
  ]
]
Notice that the eigenvectors of $M_mu$ are the same as those of $A$ since $M_mu = X(Lambda - mu I_n) X^(-1)$, where $Lambda = "diag"(lambda_1, dots, lambda_n)$. For this reason, the Rayleigh quotient in @InversePowerMethod is computed directly on the matrix $A$. The main diﬀerence with respect to @PowerMethod is that at each step $k$ a linear system with coeﬃcient matrix $M_mu = A - mu I$ _must be solved_.

== QR Iterative Method
In this section we present some iterative techniques for simultaneously approximating all the eigenvalues of a given matrix $A$. The basic idea consists of reducing $A$, by means of suitable similarity transformations, into a form for which the calculation of the eigenvalues is easier than on the starting matrix.

Let $A in CC^(n times n)$. The QR algorithm computes an upper triangular matrix $T$ and a unitary matrix $U$ such that $A=U T U^H$.
#pseudocode-list(line-numbering: none, booktabs: true, title: smallcaps[QR Iterative Method], line-gap: 1em)[
  + Set $A^((0))=A$, $U^((0))=I$
  + *While*(Stopping criterion is not satisfied)
    + Compute the QR factorization: $A^((k-1))=Q^((k)) R^((k))$
    + Update the matrix: $A^((k))=R_k Q_k$
    + Update the unitary matrix: $U^((k))=U^((k-1)) Q^((k))$
  + Return $T=A^((k)), U=U^((k))$
]
Notice that
+ $A^((k))=R^((k))Q^((k))=[Q^((k))]^H A^((k-1)) Q^((k))$, therefore $A^((k))$ is similar to $A^((k-1))$.
+ Moreover, from the above observaSon, we have $A^((k))=[Q^((k))]^H dots [Q^((1))]^H A^((0)) [Q^((1))] dots Q^((k))$.
== The Lanzos algorithm
The Lanczos algorithm can be used to efficiently find the extremal eigenvalues(maximum and minimum) of a symmetric matrix $A$ of size $n times n$.

It is based on computing the following decomposition of $A$:
$
  A = Q^T T Q
$
where $Q$ is an orthonormal basis of vectors $bold(q)_1, dots, bold(q)_n$ and $T$ is a tridiagonal matrix of size $n times n$. The decomposiSon always exists and is unique provided that $bold(q)_1$ has been specified.

We know that $T=Q^T A Q$ which gives
$
  alpha_k =& bold(q)_k^T A bold(q)_k \
  beta_k =& bold(q)_(k+1)^T A bold(q)_k \
$
The full decompostion is obtained by imposing $A Q= Q T$:
$
  A bold(q)_1 =& alpha_1 bold(q)_1 + beta_1 bold(q)_2 \
  A bold(q)_2 =& beta_1 bold(q)_1 + alpha_2 bold(q)_2 + beta_2 bold(q)_3 \
  dots \
  A bold(q)_n =& beta_(n-1) bold(q)_(n-1) + alpha_n bold(q)_n
$

#pagebreak()
= Numerical methods for overdetermined linear systems of equations
Overdetermined linear systems of equations are systems of equations in which the number of equations is greater than the number of unknowns. In this case, the system is said to be _overdetermined_. When the problems are linear there is a very clean and simple way to find the optimum, if we adopt the sum-of-squares error metric.

== Linear Regression
If there were no experimental uncertainty the model would fit the data exactly, but since there is noise the best we can do is minimise the error. The problem is:
$
  min_(alpha_0, alpha_1) sum_(i=1)^m bold(e)_i^2 = min_(alpha_0, alpha_1) sum_(i=1)^m (alpha_0 + alpha_1 T_i - L_i)^2
$
The above problem is equivalent to the following:
$
  min_(alpha_0, alpha_1) norm(bold(e))^2 = min_(alpha_0, alpha_1) norm(A bold(alpha) - bold((b)))^2
$
with $A = [1, T_1; 1, T_2; dots; 1, T_m]$ and $bold(alpha) = [alpha_0, alpha_1]^T$, $bold(b) = [L_1, L_2, dots, L_m]^T$.

== The Least Squares Solution
The mathematical problem reads: given a matrix $A in RR^(m times n)$ and a vector $bold(b) in RR^m$, find the vector $bold(x) in RR^n$ such that:
$
  A bold(x) = bold(b)
$
We notice that generally the above problems has no solution (in the classical sense) unless the right side
$b$ is an element of range($A$). We need a new concept of solution, the basic approach is to look for an $bold(x)$ that makes $A bold(x)$ close to $bold(b)$.

#definition("Least Squares Solution")[
  Given a matrix $A in RR^(m times n), m gt.eq n$, we say that $bold(x)^ast in RR^(n)$ is a solution of the linear system $A bold(x) = bold(b)$ in the sense of _least squares_ if
  $
    Phi(bold(x)^ast) = min_{bold(y) in RR^n} Phi(bold(y))
  $
  where $Phi(bold(y)) = norm(A bold(y) - bold(b))^2$.
  The problem thus consists of minimising the Euclidean norm of the residual.

  The solution $bold(x)^ast$ can be found by imposing the condition that the gradient of function $Phi$ must be zero at $bold(x)^ast$.

  From the definition we have
  $
    nabla Phi(bold(x)^ast) = nabla norm(A bold(x)^ast - bold(b))^2 = 2 A^T (A bold(x)^ast - bold(b)) = 0
  $
  from which it follows that $A^T A bold(x)^ast = A^T bold(b)$.
]

#theorem("Exists and Unique")[
  The system of normal equations is nonsingular if $A$ has full rank and, in such a case, the least squares solution exists and is unique.
]

We notice that $B=A^T A$ is a SPD matrix. Thus, in order to solve the normal equations, one could first compute the Cholesky factorization of $B$, by solving two triangular systems:
$
  R bold(z) = A^T bold(b) \
  R bold(x)^ast = bold(z)
$
However, $A^T A$ is very badly conditioned and, due to roundoff errors, the computation of $A^T A$ may be affected by a loss of significant digits, with a consequent loss of positive definiteness or nonsingularity of the matrix!

#theorem("Solution in Reduced QR Factorization")[
  Let $A in RR^(m times n), m gt.eq n$, *be a full rank matrix*, and let $A=hat(Q) hat(R)$ be the reduced QR factorization of $A$. Then the unique solution in the least-square sense of the system $A bold(x) = bold(b)$ is given by
  $
    bold(x)^ast = hat(R)^(-1) hat(Q)^T bold(b)
  $
  Moreover, the minimum of the function $Phi$ is given by
  $
    Phi(bold(x)^ast) = sum_(i=n+1)^m [(Q^T bold(b))_i]^2
  $
]

== SVD
If $A$ does not have full rank, the above solution techniques above fail. In this case if $bold(x)^ast$ is a solution in the least square sense, the vector $bold(x)^ast + bold(z)$, with $bold(z) in N(A)$, is also a solution. We must therefore introduce a further constraint to enforce the uniqueness of the solution. Typically, one requires that $bold(x)^ast$ has minimal Euclidean norm, so that the least squares problem can be formulated as:
$
  "Find" bold(x)^ast "such that" norm(A bold(x)^ast-bold(b))^2 lt.eq min_(bold(x) in RR^n) norm(A bold(x)-bold(b))^2
$ <LeastSquaresProblem>
This problem is consistent with our formulation. If $A$ has full rank, since in this case the solution in the least-square sense exists and is unique it necessarily must have minimal Euclidean norm. The tool for solving @LeastSquaresProblem is the singular value decomposition(SVD).

#definition("pseudo-inverse")[
  Suppose that $A in RR^(m times n)$ has rank equal to $r$ and let $A=U Sigma V^T$ be the SVD of $A$. The _pseudo-inverse_ of $A$ is the matrix
  $
    A^dagger = V Sigma^dagger U^T
  $
  where $Sigma^dagger$ is the $n times m$ matrix obtained by taking the reciprocal of the nonzero singular values of $Sigma$ and transposing the result.

  The matrix $A^dagger$ is also called the _generalized inverse_ of $A$. And if $n=m="rank"(A)$, then $A^dagger = A^(-1)$.
]
#pagebreak()

= Direct Methods for Linear Systems
== Solution of Triangular Systems
Consider the nonsingular $3 times 3$ *lower triangular* system:
$
  mat(l_11, 0, 0; l_21, l_22, 0; l_31, l_32, l_33) vec(x_1, x_2, x_3) = vec(b_1, b_2, b_3)
$
Since the matrix is nonsingular, its diagonal entries $l_(i i)$ are nonzero, hence we can solve sequentially for the unknown values $x_i$, as follows:
$
  x_1 = b_1 slash l_11 \
  x_2 = (b_2 - l_21 x_1) slash l_22 \
  x_3 = (b_3 - l_31 x_1 - l_32 x_2) slash l_33
$
This algorithm can be extended to systems $n times n$ and is called _forward substitution_. In the case of system #lower_triangular_system, with $L$ being a nonsingular lower triangular matrix of order $n(n gt.eq 2)$, the method is as follows:
$
  x_1 = b_1 slash l_11 \
  x_n = 1 / l_(i i) (b_i - sum_(j=1)^(i-1) l_(i j) x_j), i = 2, dots, n
$
The number of multiplications and divisions to execute the algorithm is equal to $n(n+1) / 2$, while the number of sums and subtractions is $n(n-1) / 2$. The global operation count for the forward substitution is $n^2$.

Similar conclusions can be drawn for a linear system #upper_triangular_system, with $U$ being a nonsingular upper triangular matrix of order $n(n gt.eq 2)$. In this case the algorithm is called _backward substitution_ and in the general case can be written as:
$
  x_n = b_n / u_(n n) \
  x_i = 1 / u_(i i) (b_i - sum_(j=i+1)^(n) u_(i j) x_j), i = n-1, dots, 1
$
Its computational cost is the same as that of the forward substitution.

== Guassian Elimination and LU Factorization
Consider a nonsingular matrix $A in RR^(n times n)$, and suppose that the diagonal entries $a_(i i)$ is nonzero. Introducing the _multiplers_:
$
  m_(i 1) = a_(i 1)^((1)) / a_(1 1)^((1)), i = 2, dots, n
$
where $a_(i 1)^((1))$ denote the elements of $A^((1))$, it is possible to eliminate the unknown $x_1$ from the rows other than the first one by simply subtracting from row $i$, with $i=2, dots, n$, the first row multiplied by $m_(i 1)$ and doing the same on the right side. If we now define
$
  a_(i j)^((2))=&a_(i j)^((1)) - m_(i 1) a_(1 j)^((1)), i, j = 2, dots, n \
  b_i^((2))=&b_i^((1)) - m_(i 1) b_1^((1)), i = 2, dots, n
$
where $b_i ^((1))$ denotes the elements of $bold(b)^((1))$, we have the following system:
$
  mat(a_(1 1)^((1)), a_(1 2)^((1)), dots, a_(1 n)^((1)); 0, a_(2 2)^((2)), dots, a_(2 n)^((2)); dots; 0, 0, dots, a_(n n)^((n))) vec(x_1, x_2, dots, x_n) = vec(b_1^((1)), b_2^((2)), dots, b_n^((n)))
$
which we denote by $A^((2)) bold(x) = bold(b)^((2))$. that is equivalent to the starting one. Similarly, we can transform the system in such a way that the unknown $x_2$ is eliminated from rows $3, dots, n$,.In general, we end up with the finite sequence of systems
$
  A^((k)) bold(x) = bold(b)^((k)), k = 1, dots, n
$
where, for $k gt.eq 2$, matrix $A^((k))$ takes the following form:
$
  A^((
    k
  )) = mat(a_(1 1)^((1)), a_(1 2)^((1)), dots, a_(1 n)^((1)); 0, a_(2 2)^((2)), dots, a_(2 n)^((2)); dots; 0, 0, dots, a_(k k)^((k))) = L^((
    k
  )) U^((k))
$
It is clear that for $k=n$ we obtain the upper triangular system $U bold(x) = bold(b)^((n))$ which can be solved by backward substitution.

#theorem("Existence and Uniqueness")[
  Let $A in RR^(n times n)$. The LU factorization of $A$ with $l_(i i) = 1$ for $i=1, dots, n$ exists and is unique iff the principal submatrices $A_i$ of $A$ of order $i=1, dots, n-1$ are nonsingular.
]

#theorem("Sufficient Condition for Gaussian Elimination")[
  Let $A in RR^(n times n)$ be a nonsingular matrix. The LU factorization of $A$ exists and is unique if $A$ follows the below two conditions:
  + $A$ is strictly diagonally dominant by rows / columns
  + $A$ is symmetric and positive definite
]

== Pivoting techniques
As previously pointed out, the GEM process breaks down as soon as a zero pivotal entry is computed. In such case, one needs to resort to the so-called _pivoting techniques_, which amounts to exchanging rows(columns) of the system in such a way that nonzero pivotal elements are always available. So the $L U$ factorization becomes:
$
  P A = L U
$
where $P$ is a permutation matrix. To solve linear system $A bold(x)=bold(b)$, we solve the equivalent system $P A bold(x)=P bold(b)$, which can be solved by the following two triangular systems:
$
  L bold(y) = P bold(b) \
  U bold(x) = bold(y)
$
Moreover, the piovtal element should be as large as possible to avoid round-off errors. In practice:
+ doing pivoting even when it is not strictly needed.
+ Swap the row $k$ with the row $i$, where $i$ is the row with the largest pivotal element in the $k$-th column.