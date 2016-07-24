function n = Tikhonov_TV_min_problem(x, b, lambda, beta, theta)
%Tikhonov_TV_min_problem returns the optimization problem
%for the Radon inversion problem regularised with the TV-seminorm and
%the 2-norm. The function requires General_TV and General_Radon
%to be added to path, and takes the parameters:
% x: Evaluating variable
% b: Original data
% lambda: TV regularisation parameter
% beta: Tikhonov regularisation parameter
% theta: Angles to project over

n = unregularised_residual(x, b, theta) + 2*lambda*TV_Isotropic(x) + beta*norm(x, 'fro');

end

