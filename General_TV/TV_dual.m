function x = TV_dual(p, q)
% TV_dual(p, q) calculates the linear map used for calculating the dual 
% problem for the TV-seminorm optimization problem. It takes parameters:
%    p: First dual variable (in R^(n-1*m))
%    q: Second dual variable (in R^(n*(m-1))

[~, n] = size(p);
[m, ~] = size(q);

p2 = zeros(m+1, n+1);
p2(2:m, 2:end) = p;
q2 = zeros(m+1, n+1);
q2(2:end, 2:n) = q;

x = p2(2:m+1, 2:n+1) + q2(2:m+1, 2:n+1)...
                -(p2(1:m, 2:n+1)   + q2(2:m+1, 1:n));  
end

