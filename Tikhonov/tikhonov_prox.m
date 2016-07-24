function prox = tikhonov_prox(x, b, beta, theta, L)
% tikhonov_prox(x, b, beta, theta, L) returns the proximal map of the Radon 
% inversion problem, regularised with the 2-norm. The function requires 
% General_Radon to be added to path, and takes parameters:
%    x: Evaluation variable
%    b: Original data
%    theta: Projection angles
%    L: Lipshitz constant of the optimisation problem
%    beta: Regularisation parameter

    RRx = unregularised_gradient(x, b, theta);
    df = RRx + beta*x;
    prox = x - df/L;
end

