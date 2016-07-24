function prox = Tikhonov_TV_prox(x, b, theta, L, lambda, beta, N)
% tikhonov_TV_prox(x, b, theta, L, lambda, beta, N) returns the proximal 
% map of the Radon inversion problem, regularised with the TV-seminorm 
% and the Eucledian norm. The function requires General_TV and 
% General_Radon to be added to path, and takes parameters:
%    x: Evaluation variable
%    b: Original data
%    theta: Projection angles
%    L: Lipshitz constant of the optimisation problem
%    lambda: Regularisation parameter for TV-seminorm
%    beta: Regularisation parameter for 2-norm
RtR = unregularised_gradient(x, b, theta);
step = (2/L)*lambda;

prox = TV_FGP(x - (2/L)*(RtR + beta*x), step, N, 0, inf ); %D(x - (2/L)Rt(Rx-b))

end

