function [ p, q ] = TV_dual_adj(x)
% TV_dual_adj(x) calculates the transpose of the linear map used for
% calculating the dual problem of the TV-seminorm optimization problem. It
% takes the parameter:
%    x: Image to calculate dual from.

[n, m] = size(x);

p = x(1:n-1, :) - x(2:n, :);
q = x(:, 1:m-1) - x(:, 2:m);
end

