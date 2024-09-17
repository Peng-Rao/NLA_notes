#import "../template.typ": *
#import "@preview/codelst:2.0.1": sourcecode

= Iterative methods for large linear systems

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