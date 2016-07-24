function N = unregularised_residual(x, b, theta)
% unregularised_residual(x, b, theta) returns the residual of the Radon 
% inversion problem with no regularisation. It takes parameters:
%    x: Guess image
%    b: Observed sinogram
%    theta: Angles to project over

N = norm(radon(x, theta) - b, 'fro');

end

