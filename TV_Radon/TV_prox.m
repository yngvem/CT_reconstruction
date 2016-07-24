function prox = TV_prox(x, b, beta, theta, L, N)
% TV_prox(x, b, beta, theta, L, N) returns the proximal map of the Radon 
% inversion problem, regularised with the TV-seminorm. The function 
% requires General_TV and General_Radon to be added to path. 
% It takes parameters:
%    x: Evaluation variable
%    b: Original data
%    theta: Projection angles
%    L: Lipshitz constant of the optimisation problem
%    beta: Regularisation parameter

RtR = unregularised_gradient(x, b, theta);
step = (2/L)*beta;

prox = TV_FGP(x - 2*RtR/L, step, N, 0, inf ); %D(x - (2/L)Rt(Rx-b))

end

