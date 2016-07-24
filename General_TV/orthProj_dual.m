function [ r, s ] = orthProj_dual(p, q)
% orthProj_dual(p,q) calculates the orthogonal projection onto the feasible
% set of the dual problem for the TV minimisation problem. It takes the
% parameters:
%    p: First dual variable (in R^(n-1*m))
%    q: Second dual variable (in R^(n*(m-1))

%Set up initial variables
r = zeros(size(p));
s = zeros(size(q));
L = sqrt(p(:, 1:end-1).^2 +q(1:end-1, :).^2);
[~, n] = size(p);
[m, ~] = size(q);

%Find divisor
onesL = ones(size(L));
divided_by = max(onesL, L);
divided_by_r = max(ones(m-1, 1), abs(p(:, end)));
divided_by_s = max(ones(1, n-1), abs(q(end, :)));

%Do projections
r(:, 1:end-1) = p(:, 1:end-1)./divided_by;
r(:, end) = p(:, end)./divided_by_r;
s(1:end-1, :) = q(1:end-1, :)./divided_by;
s(end, :) = q(end, :)./divided_by_s;

end

