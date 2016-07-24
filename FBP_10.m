clc
addpath('L1', 'TV_Radon', 'General_TV', 'General_Radon', 'tikhonov',...
        'FBP', 'OptFunc')
    
%Generate raw data
n = 128;
P = phantom(n);
theta = 1:1:180;
R = radon(P, theta);

%Add noise
I = findIntensity(R, 0.1, n);
Rnoise = add_noise(R, I, n);

%Set regularisation variables
filter_SL = 'shepp-logan';
filter_RL = 'ram-lak';
cutoff_1 = 1;
cutoff_05 = 0.8;

FBP_SL_1 = FBP(Rnoise, theta, filter_SL, cutoff_1);
FBP_RL_1 = FBP(Rnoise, theta, filter_RL, cutoff_1);
FBP_SL_05 = FBP(Rnoise, theta, filter_SL, cutoff_05);
FBP_RL_05 = FBP(Rnoise, theta, filter_RL, cutoff_05);

figure
subplot(1,2,1)
imshow(FBP_SL_1);
title(sprintf('Shepp-Logan\nNyquist frequency'));

% subplot(2,2,2)
% imshow(FBP_RL_1, []);
% title('Ram-Lak, 100%');

subplot(1,2,2)
imshow(FBP_SL_05, []);
title(sprintf('Shepp-Logan\n80%% Nyquist frequency'));
saveas(gcf,'FBP_10.png')
% subplot(2,2,4)
% imshow(FBP_RL_05, []);
% title('Ram-Lak, 50%');
