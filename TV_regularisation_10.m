clc
addpath('L1', 'TV_Radon', 'General_TV', 'General_Radon', 'Tikhonov',...
        'FBP', 'OptFunc')

%Generate raw data
n = 128;
P = phantom(n);
theta = [1:1:40, 60:90, 100:120, 140:180];
R = radon(P, theta);

%Set experimental variables
beta = 0.1;                                                                %Regularisation parameter
N = 100;                                                                    %No of FISTA iterations
M = 30;                                                                     %No of FGP iterations
x0 = zeros(n);                                                              %Initial guess
L = 128;                                                                     %Lipshitz gradient
showIt = 1;                                                                 %Show iterations

I = findIntensity(R, 0.01, n);                                                                    %Noise level
Rnoise = add_noise(R, I, n);                                                   %Add noise to sinogram
TV_reg_10 = TV_reg(x0, Rnoise, beta, theta, L, M, N, showIt);               %Reconstruct image

figure

subplot(1,2,1)
imshow(TV_reg_10(:,:,end))                                                  %Show reconstructed image
title('TV Regularisation, 10% noise')

subplot(1,2,2)
imshow(iradon(Rnoise, theta));                                              %Show FBP reconstruction
title('Filtered Backprojection, 10% noise')

saveas(gcf,'TV_regularisation_10.png')

% figure
% fit = zeros(size(TV_reg_10, 3), 1);
% fit2 = fit;
% for i = 1:size(TV_reg_10, 3)
%     fit(i) = TV_min_problem(TV_reg_10(:,:,i), Rnoise, beta, theta);
% end
% 
% subplot(1,2,1)
% % plot(fit)
% for i = 1:size(TV_reg_10, 3)
%     fit2(i) = norm(TV_reg_10(:,:,i) - P, 'fro');
% end
% 
% % subplot(1,2,2)
% figure
% plot(fit2)


% figure
% for i = 1:size(TV_reg_10, 3)
%     imshow(TV_reg_10(:,:,i))
%     title(int2str(i));
% end