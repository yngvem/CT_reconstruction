function [ dh_p, dh_q ] = dual_TV_gradient(p, q, b, lamda, l, u)
% dual_TV_gradient(p, q, b, lambda, l, u) returns the gradient of the dual
% problem for optimizing TV regularised denoising problem. It takes the
% parameters:
%    p: First dual variable
%    q: Second dual variable
%    b: Original image
%    lambda: Regularisation parameter
%    l: Lower bound for pixel values
%    u: Upper bound for pixel values

[dh_p, dh_q] = TV_dual_adj( orthProj( l, u, b - lamda*TV_dual(p, q)));
end

