function n = TV_min_problem(x, b, beta, theta)
% TV_min_problem(x, b, beta, theta) returns the optimization problem
% for the Radon inversion problem regularised with the TV-seminorm. 
% The function requires General_TV and General_Radon to be added to path,
% and takes the parameters:
%    x: Evaluating variable
%    b: Original data
%    beta: Regularisation parameter
%    theta: Angles to project over

n = unregularised_residual(x, b, theta) + 2*beta*TV_Isotropic(x);
end

