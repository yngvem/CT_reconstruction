clc
addpath('L1', 'TV_Radon', 'General_TV', 'General_Radon', 'Tikhonov',...
        'FBP', 'OptFunc')

%Generate raw data
n = 128;
P = phantom(n);
theta = 1:1:180;
R = radon(P, theta);

%Set experimental variables
beta = 0.15;                                                                %Regularisation parameter
N = 100;                                                                    %No of FISTA iterations
M = 30;                                                                     %No of FGP iterations
x0 = zeros(n);                                                              %Initial guess
L = 275;                                                                     %Lipshitz gradient
showIt = 1;                                                                 %Show iterations

I = findIntensity(R, 0.05, n);                                                                    %Noise level
Rnoise = add_noise(R, I, n);                                                   %Add noise to sinogram
TV_reg_05 = TV_reg(x0, Rnoise, beta, theta, L, M, N, showIt);               %Reconstruct image

figure
subplot(1,2,1)
imshow(TV_reg_05(:,:,end))                                              %Show reconstructed image
title('TV Regularisation, 5% noise')

subplot(1,2,2)
imshow(iradon(Rnoise, theta));                                              %Show FBP reconstruction
title('Filtered Backprojection, 5% noise')
saveas(gcf,'TV_regularisation_05.png')
% figure
% fit = zeros(size(TV_reg_05, 3), 1);
% fit2 = fit;
% for i = 1:size(TV_reg_05, 3)
%     fit(i) = TV_min_problem(TV_reg_05(:,:,i), Rnoise, beta, theta);
% end
% 
for i = 1:size(TV_reg_05, 3)
    fit2(i) = unregularised_residual(TV_reg_05(:,:,i), Rnoise, theta);
end
% 
for i = 1:size(TV_reg_05, 3)
    fit3(i) = norm(TV_reg_05(:,:,i) - P, 'fro');
end
figure
subplot(1,2,1)
plot(fit2)
subplot(1,2,2)
plot(fit3)
% 
% 
% subplot(1,3,1)
% plot(fit)
% subplot(1,3,2)
% plot(fit2)
% subplot(1,3,3)
% plot(fit3)