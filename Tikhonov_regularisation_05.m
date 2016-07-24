clc
addpath('L1', 'TV_Radon', 'General_TV', 'General_Radon', 'Tikhonov',...
        'FBP', 'OptFunc')

%Generate raw data
n = 128;
P = phantom(n);
theta = 1:1:180;
R = radon(P, theta);

%Set experimental variables
beta = 0.05;                                                                %Regularisation parameter
N = 100;                                                                    %No of FISTA iterations
M = 30;                                                                     %No of FGP iterations
x0 = zeros(n);                                                              %Initial guess
L = 64;                                                                     %Lipshitz gradient
showIt = 1;                                                                 %Show iterations

I = findIntensity(R, 0.05, n);                                                                   %Noise level
Rnoise = add_noise(R, I, n);                                                   %Add noise to sinogram
tikhonov_05 = tikhonov_reg(x0, Rnoise, beta, theta, L, N, showIt);          %Reconstruct image

figure
subplot(1,2,1)
imshow(tikhonov_05(:,:,end))                                                %Show reconstructed image
title('Tikhonov, 5% noise')

subplot(1,2,2)
imshow(iradon(Rnoise, theta));                                              %Show FBP reconstruction
title('Filtered Backprojection, 5% noise')

saveas(gcf,'Tikhonov_regularisation_05.png')
% 
% figure
% fit = zeros(size(tikhonov_05, 3), 1);
% fit2 = fit;
% for i = 1:size(tikhonov_05, 3)
%     fit(i) = tikhonov_min_problem(tikhonov_05(:,:,i), Rnoise, beta, theta);
% end
% 
% for i = 1:size(tikhonov_05, 3)
%     fit2(i) = norm(tikhonov_05(:,:,i) - P, 'fro');
% end
% % subplot(1,2,1)
% % plot(fit)
% % subplot(1,2,2)
% figure
% plot(fit2)

