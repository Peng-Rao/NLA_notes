%% Excercise 1.6
realmax
a = 1.0e+308;
b = -a;
c = 1.1e+308;
(a + b) + c %Expected results
(a + c) + b %Overflow
