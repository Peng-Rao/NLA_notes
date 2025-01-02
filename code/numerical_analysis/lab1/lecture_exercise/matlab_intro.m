%{
	\subsection{GUI description}
	\begin{itemize}
	\item \textbf{Command window}: where you digit the commands and visualize the results;
	\item \textbf{Command history}: there you can visualize previously used commands and re-execute them in the command line by just clicking on them;
	\item \textbf{Current folder}: MATLAB has a working directory. It looks in it for the
		functions that are not native and it saves in it by default. You can
		edit functions from there. You can change it also from the upper bar;
	\item \textbf{Workspace}: it displays all the created variables with their type and size;
	\item \textbf{Editor}: here you can write a script or a function and save it as an .m
		file in your working directory. Then you can execute/call it from the
		command line as usual.
	\end{itemize}
%}

%{
	\subsection{Basic MATLAB usage}
%}
% a] Assignment operation:
a = 1 % with echo
b = 2; % without echo

% b] Recall previous commands:
% You can recall previously used commands with up and down arrows. If you already know a part of the command you want to recall, you can digit it and then use up and down arrows.

% c] Scripts:
% When using the editor you can write the script and then execute it from the command line. Remember, the script has to be in the working directory in order to be executed.

% d] Save/load history or the current status of the workspace
% Current workspace variables
whos % will display all the variables
whos a % will display only the variable a
% Save
diary matlab_intro.txt % saves the history
save matlab_intro % saves the whole workspace
a = 3;
save matlab_intro_ONLYa a % saves only the variables a, but no the variable b
% Clear the workspace
clear a % clears only the variable a
whos a % a does not exists anymore
clear all % clears every remaining variable (in this case, the variable b)
whos % empty workspace
% Load
load matlab_intro_ONLYa % this will load only the variable a, with value a = 3
whos
load matlab_intro % this will overwrite the current variable a to restore a = 1, and also load b = 2
whos

%{
	\subsection{Vector and matrices}
%}
% Most of the entities in MATLAB are matrices, even real numbers! Indeed:
whos a % is a 1-by-1 matrix

%% Vector and matrix generation
% !Row! vectors can be defined writing the elements separated by a !space!, with square brackets delimiting the sequence ...
c = [1 2 3]
% ... or, equivalently, using commas instead of the spaces
c = [1, 2, 3]

% !Column! vectors can be defined writing the elements separated by a !semicolon!, with square brackets delimiting the sequence
c = [1; 2; 3]

% Transposition is performed with an apostrophe: the following command produces a column vector
c = [1 2 3]'

% Spaces (or commas) and semicolons can be combined in order to define matrices ...
D = [1 2 3; 4, 5, 6; 7 8 9]
% ... transposition works on matrices too.
D = D'

% When defining a matrix, pay attention to the number of elements in each row/column. They have to be coherent.
D_wrong = [1 2; 3 4 5]

% There are other ways to create vectors and matrices: if you are interested in vectors with evenly spaced elements it is possible to use the following syntax ...
e = [1:1:10] % syntax: [beginning:step_size:end]
f = [1:10:101]
g = [0:0.1:1]
h = [10:-1:1]
e = [1:10] % the step_size can be omitted if step_size = 1. syntax: [beginning:end]
% or the linspace command.
ee = linspace(1, 10, 10) % sintax: linspace(beginning, end, n_of_elements)
ff = linspace(1, 101, 11)
gg = linspace(0, 1, 11)
hh = linspace(10, 1, 10)

% You can also a zero vector/matrix ...
i = zeros(1, 5) % row vector in IR^5
j = zeros(5, 1) % column vector in IR^5
K = zeros(3, 4) % matrix in IR^{3x4}
L = zeros(2, 2) % matrix in IR^{2x2}
M = zeros(2) % matrix in IR^{2x2}
% .. or ones matrices ..
n = ones(1, 4)
O = ones(2)
% .. or indentity matrices.
P = eye(3)
Q = eye(3, 5) % rectangular too!!
% .. or diagonal matrix
d = [1:4];
D = diag(d)
% Beware of the different of "diag" wheter the argument is a vector (as before) or a matrix
M = [1:3; 4:6; 7:9];
diagM = diag(M) % diagM now contains the diagonal part of the matrix M, ie diagM = [M_ii]_i
Md = diag(diag(M)) % Md is a copy of M, in which a value 0 has been overwritten over the original value of each element outside the diagonal
% Diag also accepts a second argument. In that case it takes the upper or lower diagonals
Dup = diag(d, 1) % matrix: the values of the first upper diagonal are taken from d
Dbottom = diag(d, -2) % matrix: the values of the second lower diagonal are taken from d
diagMup = diag(M, 1) % vector containing the values of the first upper diagonal
diagMbottom = diag(M, -2) % vector containing the values of the second lower diagonal
% tril and triu commands take instead the lower and upper triangular part of a matrix.
Ml = tril(M)

% You can also build vectors and matrices by composing blocks..
r_minus = [-5:1:-1];
r_plus = [0:5];
r = [r_minus, r_plus]
%
S1 = [1 2; 5 6];
S2 = [3 4; 7 8];
S3 = [9, 10, 11];
S4 = [12];
S = [S1, S2; S3, S4]
% ... but when you do this, pay attention  to the dimension of each block!
r_wrong = [r_minus, r_plus']
S_wrong = [S1, S2; S3]

% Clear
clear all

%% Vector and matrix r/w access
% In order to access to vector and matrix elements we use the () operator.
% It works in both directions, access to read and access to write.
% IMPORTANT: MATLAB indexing starts from 1, unlike C++ for example, where indexing starts from 0.
c = [1:3]
c1 = c(1)
%
Q = ey(3, 5);
Q11 = Q(1, 1) % Read access
Q12 = Q(1, 2)
%
Q
Q(1, 1) = 15 % Write access
Q

% You can also access to blocks of the matrices, by indicating the indexes of the rows and columns you want to consider.
c
c([2, 3])
Q
Q([1, 2], [1, 3, 4])

% In this operation the operator : is helpful. You can select ranges of rows and columns ..
Q([1:2], [1:3]) % First two rows and three columns
% .. or leave a mute index, to mean to get all the indices in that direction
Q(:, 1:3) % Take all the rows and the first three columns
Q(1, :) % Take all the columns and just the first row

% The end operator is and indicator for the last index in an indexing
% expression
Q(end, end) % Take the bottom right element of Q.

% Clear
clear all

%{
	\subsection{Vector operations}
%}
a = [1 -2 1 0];
b = [3 4 1 -2];
c = a + b % vector sum
d = a - b % vector difference

% Now we would like to perform the scalar product between vectors a and b.
% Try
e = a * b
% MATLAB says that the dimensions of a and b have something wrong, even if they both have 4 elements, as can be seen with
length(a)
numel(b) % length and numel are equivalent for vectors
% Remember that MATLAB stores vectors as matrices and for this reason they have to satisfy the requirements for matrix product:
% 	number of columns of the first matrix = number of rows of the second matrix
% which is clearly violated in this case.

% The scalar product between a and b can be computed with
e = a * b'
% .. or
e = dot(a, b)
% The tensor product F_{ij} = a_i b_j can be computed with
F = a' * b
% Elementwise operations between two vectors are defined !if!  the two vectors have the same number of elements:
% * elementwise product:
g = a .* b
% * elementwise division:
h = a ./ b
% * elementwise exponentiation
i = a .^ b
j = a .^ 2

%{
	\subsection{Matrix operations}
%}
K = [1 -1 2; 4 -2 0];
L = [1 2 2; 3 -3 1];
M = K + L % matrix sum
N = K - L % matrix difference

% If two matrices satisfy the usual dimensional requirements their product can be computed in MATLAB
O_wrong = K * L % is wrong, as can be seen with the "size" command
size(K)
size(L)
O = K * L' % ok

% Elementwise operations between two matrices are defined !if!  the two matrices have the same size:
% * elementwise product:
P = K .* L
% * elementwise division:
Q = K ./ L
% * elementwise exponentiation
R = K .^ 2
S = K .^ L
% The power matrix operation K^2 = K*K is meaningful only for square matrices.
T = K ^ 2
U = F ^ 2

% Clear
clear all

% The determinant of a matrix is obtained with the det command
A = [1 2 3; -2 3 -1; 0 1 2];
det(A)
% The trace (the sum of the diagonal elements) is obtained with the trace operator.
trace(A)
% In order to compute the inverse of a (small) matrix you can use the inv function.
invA = inv(A)
% Check
A * inv(A) % = identity
% This function is very expensive (and may fail, A*A^-1 not being the identity matrix!) and is not used in practice: for big matrices and you DO NOT have to use it for solving linear systems!!
% We will see some numerical methods for the resolution of linear systems. Moreover, the backslash operator can be used to solve efficently a linear system
b = [1 2 3]';
x = A \ b % x is the solution of Ax = b
% Check
A * x
b

% Clear
clear all

%{
	\subsection{Plotting}
%}
% We now describe some essential commands for 2D plotting
% The most simple technique to plot functions is to discretize an interval and then evaluate the function in the obtained points.
% Plot the function y = x^2 - x + sin(pi*x) in [0,2]
x = 0:0.1:2;
y = x .^ 2 - x + sin(pi * x); % NOTICE the use of the .^ operation
figure % Open a figure window
plot(x, y)
% Increase the number of nodes
hold on % plot on the same graph, for a comparison
x2 = 0:0.01:2;
y2 = x2 .^ 2 - x2 + cos(pi * x2);
plot(x2, y2, 'r') % 'r' = red color
% Other helpful options:
grid on % draw a grid on the graph
axis([0 2 1 2]) % set the limits on the x and y axes. Syntax: axis([xmin xmax ymin ymax])
axis equal % The scaling of the axes might be different. The same scaling is forced using the axis equal command

% Clear and close all figures
clear all
close all

%{
	\subsection{Function handles}
%}
% A function handle is a pointer to another function and it is defined with  the syntax
%     @function-name

% For example,
f = @sin;
% creates a function handle called f that refers to the function sin (builtin in MATLAB).

% Function handles are used to call other functions indirectly, or to pass a function as an argument to another function. For example:
x = linspace(0, 2 * pi, 1000);
plot(x, f(x), 'Linewidth', 2)

% A function handle can be evaluated writing its name followed by an argument list. If there are no arguments, you must use an empty argument list  '()'. For example:
f(pi / 4) %sin(pi/4)

% Anonymous functions are defined using the syntax
%     @(argument-list) expression

% Any variable that is not found in the argument list is inherited from the enclosing scope. Anonymous functions are useful for creating simple unnamed functions from expressions or for wrapping calls to other functions to adapt them for use by functions. For example:
f = @(x) x .^ 2;
hold on
plot(x, f(x), 'r-', 'Linewidth', 2)

% Function handles can be used to reshape the form of a function in order to satisfy the requirements of another function. As an example, quad is a function for performing numerical integration. It needs single variable functions. Suppose we have
g = @(x, y) sin(x) .* cos(y);
% and we need to compute the integral for x in [0, 1] and y = 0.
% With the function handles we can transform a two-argument function f into a single-argument one with
y = 0;
quad (@(x) g(x, y), 0, pi)
% Clear and close all figures
clear all
close all

%{
	\subsection{Logicals}
%}
% Sometimes you have to work with logical conditions (expression that return either true or false).
% True is associated with 1 and false with 0
true
false

% MATLAB offers some logical operators (e.g. equal, less, and, or, ...)
a = 1;
b = 2;
c = 3;
d = 2;
% Logical operators
a < b % Smaller than
b > c % Greater than
d <= b % Smaller or equal than
d == b % Equal to
a ~= b % Different from % IMPORTANT: tilde with alt+0126 on Windows
(a < b) & (b > c) % And
(a < b) | (b > c) % Or

%{
	\subsection{Control flow statements}
%}
%{
	\subsubsection{\texttt{if-then-else} statements}
%}
% The if instruction allows to execute a sequence of commands if a  particular logical condition is satisfied.
% Syntax:
% if (condition1)
%   block1
% elseif (condition2)
%   block2
% else
%   block3
% end

% Compute the factorial of a number n
n = 5;
%n = -5;
if (n < 0)
    disp('Negative n. Undefined factorial.')
elseif (n == 0)
    factorial = 1
else
    factorial = prod(1:n)
end

%{
	\subsubsection{\texttt{for} loops}
%}
%The for loop iterates a series of operations for a fixed number of times
% Syntax:
% for (index = start:step:end)
%   instruction block
% end

% Sum the first 10 integer numbers
a = 0;

for (i = 1:10)
    a = a + i;
end

a
% Nested loops: compute the Hilbert matrix of order n=4
n = 4;
A = zeros(n);

for i = 1:n

    for j = 1:n
        A(i, j) = 1 / (i + j - 1);
    end

end

A

%{
	\subsubsection{\texttt{while} loops}
%}
% The while loop repeats a sequence of operations until a logical condition becomes false.
% Syntax:
% while (condition)
%   instruction block
% end

% Sum the first 10 integer numbers
a = 0;
i = 1;

while (i < 11)
    a = a + i;
    i = i + 1;
end

a
i % should be 11

% ATTENTION! If for any reason (most of the times a programming error) the logical condition is ALWAYS satisfied, the loop is infinite. In order to stop the iterations you have to press ctrl+c!
while (true)
end

%{
	\subsection{M-files}
%}
% There are two categories of m-files.
% SCRIPTS. These files contain instructions that are executed in sequence in the command line if the script file is called.
edit matlab_intro_script.m
% The content of matlab_intro_script.m is:
% =================
% a = 1;
% b = 2;
% c = a + b;
% =================
matlab_intro_script
% The variables a, b and c are saved in the current workspace
a
b
c

% FUNCTIONS. Fuctions take some input arguments and return some outputs after a series of instructions are performed.
% Notice the particular syntax with the FUNCTION and END keywords.
edit matlab_intro_function.m
% The content of matlab_intro_function.m is:
% =================
% function sum = matlab_intro_function(num1, num2)
% 	sum = num1 + num2;
% end
% =================
% The variables defined in the function are LOCAL to the SCOPE of the function itself. There is no variable "sum"; "c" contains the output of the function
c = matlab_intro_function(a, b)
whos sum
