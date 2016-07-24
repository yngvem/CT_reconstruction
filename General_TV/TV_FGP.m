function x = TV_FGP(b, lambda, N, l, u)
% TV_FGP(b, lambdal, N, l, u) returns the denoised version of the image x 
% using TV regularization solved with the FGP algorithm. 
% It uses the parameters:
%    b: original image
%    lambda: regularization parameter
%    N: number of iterations
%    l: lower bound for pixel values
%    u: upper bound for pixel values

[m, n] = size(b);
p = zeros(m-1, n, N);   %Dual variable 1
q = zeros(m, n-1, N);   %Dual variable 2
r = p(:,:,1);           %Intermediate variable 2 for accelerated gradient descent
s = q(:,:,1);           %Intermediate variable 1 for accelerated gradient descent
t2 = 1;                 %Momentum term

wb = waitbar(0, ['Iteration ' num2str(1) ' of ' num2str(N)]);
for i = 2:N
    waitbar(i/N, wb, ['Iteration ' num2str(i) ' of ' num2str(N)]);
    t = t2;
    
    %Generate gradient of dual problem
    [dh_p, dh_q] = dual_TV_gradient(r, s, b, lambda, l, u);
    
    %Calculate next gradient update
    [p(:,:,i), q(:,:,i)] = orthProj_dual(r + dh_p/(8*lambda), ...
                           s + dh_q/(8*lambda));
    
    %Calculate momentum term and update intermediate variables
    t2 = (1 + sqrt(1 + 4*t^2))/2;
    r = p(:,:,i) + ((t-1)/t2)*(p(:,:,i)-p(:,:,i-1));
    s = q(:,:,i) + ((t-1)/t2)*(q(:,:,i)-q(:,:,i-1));
end
delete(wb);
x = orthProj(l, u, b - lambda*TV_dual(r, s));
end

