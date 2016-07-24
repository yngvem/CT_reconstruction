function Im = tikhonov_reg(x0, b, beta, theta, Lstart, N, showIt, Lmax)
% tikhonov_reg(x0, b, beta, theta, Lstart, N, showIt, Lmax) computes the 
% Tikhonov regularised solution to the Radon inversion problem. 
% The function takes the parameters:
%    x0: Initial guess
%    b: Observed sinogram
%    beta: Regularisation parameter
%    theta: Angles projected over
%    Lstart: Initial guess for Lipshitz constant (optional)
%    N: Number of iterations for FISTA (optional)
%    showIt: Show or hide iterations: (optional)
%            showIt = 0: Hide everything
%            showIt = 1: Show iteration number
%            showIt = 2: Show iteration number and display guess image
%    Lmax: Lipshitz bound (optional)

if not(exist('Lmax', 'var'))
    Lmax = 16384;
end
if not(exist('Lstart', 'var'))
    Lstart = 2;
end
if not(exist('N', 'var'))
    N = 200;
end
if not(exist('showIt', 'var'))
    showIt = 2;
end

F = @(x) tikhonov_min_problem(x, b, beta, theta);
prox = @(x, L) tikhonov_prox(x, b, beta, theta, L);


Im = adaptive_FISTA(x0, F, prox, Lstart, N, showIt, Lmax);
end

