function Im = Tikhonov_TV_reg(x0, b, beta, lambda, theta, Lstart, M, N, showIt, Lmax)
% TV_reg(x0, b, beta, theta, Lstart, M, N, showIt, Lmax) computes the 
% TV-regularised solution to the Radon inversion problem. 
% The function takes the parameters:
%    x0: Initial guess
%    b: Observed sinogram
%    beta: Tikhonov-regularisation parameter
%    lambda: TV-regularisation parameter
%    theta: Angles projected over
%    Lstart: Initial guess for Lipshitz constant (optional)
%    M: Number of iterations for FGP calculation of proximal gradient (optional)
%    N: Number of iterations for FISTA (optional)
%    showIt: Show or hide iterations: (optional)
%            showIt = 0: Hide everything
%            showIt = 1: Show iteration number
%            showIt = 2: Show iteration number and display guess image
%    Lmax: Lipshitz bound (optional)

if not(exist('Lmax', 'var'))
    Lmax = 16384;
end
if not(exist('N', 'var'))
    N = 200;
end
if not(exist('Lstart', 'var'))
    Lstart = 2;
end
if not(exist('M', 'var'))
    M = 30;
end
if not(exist('showIt', 'var'))
    showIt = 2;
end

F = @(x) Tikhonov_TV_min_problem(x, b, lambda, beta, theta);
prox = @(x, L) Tikhonov_TV_prox(x, b, theta, L, lambda, beta, M);


Im = adaptive_FISTA(x0, F, prox, Lstart, N, showIt, Lmax);
end

