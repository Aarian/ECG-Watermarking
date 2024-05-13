
clc
clear all

% Ts=1; %Given sampling period
% SNRdb = 10; %Given SNRdb
% variance = 1/(Ts*(10^(SNRdb/10))); 
% W = sqrt(variance).*randn(1,size(Xmodt,2)); %Gaussian white noise W
% Xmodt = Xmodt + W; %Add the noise

prd_time_noise = [6.16 7.06 6.39 6.49 6.21 4.81 5.75 5.77 7.58 6.91];
psnr_time_noise = [31.66 31.80 31.42 31.57 31.35 31.21 31.73 32.61 31.25 31.48];
ssim_time_noise = [75.63 79.30 70.90 72.56 69.53 68.42 73.67 78.17 72.44 80.10];
% mean(prd_wavelet_noise)
% std(prd_wavelet_noise)
% 
% mean(psnr_wavelet_noise)
% std(psnr_wavelet_noise)
% 
% mean(ssim_wavelet_noise)
% std(ssim_wavelet_noise)

prd_cosine_noise = [7.48 9.65 7.79 6.73 7.48 6.19 7.67 7.75 10.75 8.69];
psnr_cosine_noise = [30.21 30.83 30.29 31.23 30.40 28.82 30.07 31.03 28.92 30.42];
ssim_cosine_noise = [76.07 78.69 70.91 72.87 69.37 68.88 73.50 78.38 72.47 79.66];
% mean(prd_cosine_noise)
% std(prd_cosine_noise)
% 
% mean(psnr_cosine_noise)
% std(psnr_cosine_noise)
% 
% mean(ssim_cosine_noise)
% std(ssim_cosine_noise)
 
prd_wavelet_noise = [3.74 4.42 4.13 3.94 3.78 3.04 3.42 3.05 4.55 4.24];
psnr_wavelet_noise = [35.98 35.91 35.25 35.82 35.66 35.18 36.20 38.18 35.70 35.74];
ssim_wavelet_noise = [90.97 91.94 87.33 89.27 88.09 86.49 90.34 93.62 89.72 92.76];
% mean(prd_time_noise)
% std(prd_time_noise)
% 
% mean(psnr_time_noise)
% std(psnr_time_noise)
% 
% mean(ssim_time_noise)
% std(ssim_time_noise)


% [h,p] = ttest2(prd_wavelet_noise,prd_time_noise)
% [h,p] = ttest2(prd_wavelet_noise,prd_cosine_noise)

% [h,p] = ttest2(psnr_wavelet_noise,psnr_time_noise)
% [h,p] = ttest2(psnr_wavelet_noise,psnr_cosine_noise)

% [h,p] = ttest2(ssim_wavelet_noise,ssim_time_noise)
% [h,p] = ttest2(ssim_wavelet_noise,ssim_cosine_noise)

[h,p] = ttest2(prd_cosine_noise,prd_time_noise)
[h,p] = ttest2(psnr_cosine_noise,psnr_time_noise)
[h,p] = ttest2(ssim_cosine_noise,ssim_time_noise)

