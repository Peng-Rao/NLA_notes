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

