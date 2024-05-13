
clc
clear all

% prd_time = [0.30 0.46 0.65 0.68 0.60 0.33 0.40 0.20 0.27 0.26];
% prd_wavelet = [0.33 0.41 0.35 0.37 0.35 0.33 0.32 0.26 0.30 0.26];
% prd_cosine = [0.63 0.70 0.65 0.59 0.56 0.56 0.51 0.39 0.53 0.53];
% 
% [h, p] = ttest2(prd_wavelet,prd_time)
% [h, p] = ttest2(prd_wavelet,prd_cosine)
% [h, p] = ttest2(prd_time,prd_cosine)

% psnr_time = [57.98 55.75 52.20 52.03 52.43 58.57 55.53 59.34 58.61 59.61];
% psnr_wavelet = [57.22 56.86 57.33 57.24 56.52 57.23 56.96 56.40 57.50 59.30];
% psnr_cosine = [51.55 51.90 51.96 53.14 52.11 52.63 52.84 53.01 52.63 53.34];
% [h, p] = ttest2(psnr_wavelet,psnr_time)
% [h, p] = ttest2(psnr_wavelet,psnr_cosine)
% [h, p] = ttest2(psnr_time,psnr_cosine)

ssim_time = [99.90 99.85 99.71 99.51 99.10 99.88 99.77 99.84 99.89 99.93];
ssim_wavelet = [99.90 99.88 99.93 99.92 99.86 99.88 99.86 99.84 99.90 99.93];    
ssim_cosine = [99.67 99.61 99.73 99.73 99.58 99.62 99.58 99.59 99.62 99.68];
[h, p] = ttest2(ssim_wavelet,ssim_time)
[h, p] = ttest2(ssim_wavelet,ssim_cosine)
[h, p] = ttest2(ssim_time,ssim_cosine)
