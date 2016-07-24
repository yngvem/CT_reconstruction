function x = orthProj(l, u, x)
% orthProj(l, u, x) Returns the orthogonal projection of x onto the 
% feasible hypercube constrained by lower bound l and upper bound u. 
% It takes the parameters:
%    l: Lower bound
%    u: Upper bound
%    x: Image to project

if l > u
    disp('Lower bound must be less than upper bound')
    disp('Returns with lower bound u and upper bound l')
    x(x > l) = l;
    x(x < u) = u;
else
    x(x < l) = l;
    x(x > u) = u;
end
end

