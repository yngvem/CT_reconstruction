function p = L1_prox(x, b, beta, theta, L)
% L1_prox(x, b, beta, theta, L) returns the proximal map of the Radon 
% inversion problem, regularised with the 1-norm. The function requires 
% General_Radon to be added to path, and takes parameters:
%    x: Evaluation variable
%    b: Original data
%    theta: Projection angles
%    L: Lipshitz constant of the optimisation problem
%    beta: Regularisation parameter

    p = zeros(length(x));
    df = unregularised_gradient(x, b, theta);
    
    
    prox = L*x - df;
    p = p + (prox > beta) .* (prox - beta);
    p = p + (prox < beta) .* (prox + beta);
    p = p / L;
end

