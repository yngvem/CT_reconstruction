clc
addpath('L1', 'TV_Radon', 'General_TV', 'General_Radon', 'tikhonov',...
        'FBP', 'OptFunc')

n = 128;
P = phantom(n);
theta = 1:180;
R = radon(P, theta);

Rnoise = add_noise(R, findIntensity(R, 0.05, n), n);
Rnoise2 = R + 0.05*R.*randn(size(R));

Rnoise3 = add_noise(R, findIntensity(R, 0.1, n), n);
Rnoise4 = R + 0.1*R.*randn(size(R));

Rnoise5 = add_noise(R, findIntensity(R, 0.2, n), n);
Rnoise6 = add_noise(R, findIntensity(R, 0.4, n), n);
Rnoise7 = R + 0.2*R.*randn(size(R));
Rnoise8 = R + 0.4*R.*randn(size(R));

figure
subplot(1, 2,1)
imshow(iradon(Rnoise, theta))
title('Our noise model, 5%')

subplot(1,2,2)
imshow(iradon(Rnoise2, theta))
title('Normal noise, 5%')
saveas(gcf, 'noiseComparison1.png')

figure
subplot(1,2,1)
imshow(iradon(Rnoise3, theta))
title('Our noise model, 10%');

subplot(1, 2, 2)
imshow(iradon(Rnoise4, theta));
title('Normal noise, 10%');
saveas(gcf, 'noiseComparison2.png')


figure
subplot(2,2,1)
imshow(iradon(Rnoise5, theta));
title('Our noise model, 20%');

subplot(2,2,2)
imshow(iradon(Rnoise6, theta));
title('Our noise model, 40%');

subplot(2,2,3)
imshow(iradon(Rnoise7, theta));
title('Normal noise, 20%');

subplot(2,2,4)
imshow(iradon(Rnoise8, theta));
title('Normal noise, 40%');
saveas(gcf, 'noiseComparison3.png')


% 
% L = 64;
% N = 100;                                                                    %No of FISTA iterations
% M = 30; 
% showIt = 1;
% figure
% subplot(2, 2,1)
% Im = TV_reg(P*0, Rnoise, 0.2, theta, L, M, N, showIt);
% imshow(Im(:,:,end))
% title('Our noise model, 5%')
% 
% subplot(2,2,2)
% Im = TV_reg(P*0, Rnoise2, 0.02, theta, L, M, N, showIt);
% imshow(Im(:,:,end))
% title('Our noise model, 8%')
% 
% subplot(2,2,3)
% Im = TV_reg(P*0, Rnoise3, 0.02, theta, L, M, N, showIt);
% imshow(Im(:,:,end))
% title('Our noise model, 10%')
% 
% subplot(2, 2, 4)
% Im = TV_reg(P*0, Rnoise4, 0.02, theta, L, M, N, showIt);
% imshow(Im(:,:,end))
% title('Normal noise, 5%');