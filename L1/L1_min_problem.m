function f = L1_min_problem(x, b, beta, theta)
% L1_min_problem(x, b, beta, theta) returns the optimization problem for 
% the Radon inversion problem regularised with the 1-norm. The function 
% requires General_Radon to be added to path. It takes the parameters:
%    x: Evaluating variable
%    b: Original data
%    beta: Regularisation parameter
%    theta: Angles to project over

f = unregularised_residual(x, b, theta) + beta*norm(x(:), 1);
end

