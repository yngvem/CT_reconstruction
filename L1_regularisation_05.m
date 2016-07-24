clc
addpath('L1', 'TV_Radon', 'General_TV', 'General_Radon', 'tikhonov',...
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

I = findIntensity(R, 0.05, n);                                                               %Noise level
Rnoise = add_noise(R, I, n);                                               %Add noise to sinogram
L1_05 = L1_reg(x0, Rnoise, beta, theta, L, N, showIt);                      %Reconstruct image

figure
subplot(1,2,1)
imshow(L1_05(:,:,end))                                                      %Show reconstructed image
title('L1 Regularisation, 5% noise')

subplot(1,2,2)
imshow(iradon(Rnoise, theta));                                              %Show FBP reconstruction
title('Filtered Backprojection, 5% noise')                                  
saveas(gcf,'L1_regularisation_05.png')
% figure
% fit = zeros(size(L1_05, 3), 1);
% fit2 = fit;
% for i = 1:size(L1_05, 3)
%     fit(i) = L1_min_problem(L1_05(:,:,i), Rnoise, beta, theta);
% end
% 
% for i = 1:size(L1_05, 3)
%     fit2(i) = norm(L1_05(:,:,i) - P, 'fro');
% end
% subplot(1,2,1)
% plot(fit)
% subplot(1,2,2)
% plot(fit2)

