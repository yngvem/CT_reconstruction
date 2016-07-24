function R_noise = add_noise(R, I0, n)
% add_noise(R, p) returns a noisy sinogram 
% R_ij = R_ij + d_ij, with d_ij~N(0, sigma^2), sigma = p*R_ij
% The function takes the parameters:
%    R: Sinogram
%    p: noise level
m = n/8;
R2 = R/m;
R2 = I0*exp(-R2);
R2 = R2+poissrnd(1./R2);
R2 = -log(R2/I0);
R_noise = R2*m;
end

