%% Excercise 1.1
clc; clear;close all
%% Define the Row Vector vk=(1,9,25...(2k+1)^2) with k=8
k = 1e5;

% 1) For loop strategy
vk = zeros(1, k+1);
fprintf("Loop strategy: \n");
tic
for (ii = 0:k)
  vk(ii+1) = (2*ii + 1)^2;
end
toc
% 2) Vector syntax
fprintf("Vector syntax: \n");
tic
vk = [1:2:2*k+1].^2;
toc

%% Suggestion: Test the diffenrence in computational time for increasing k
