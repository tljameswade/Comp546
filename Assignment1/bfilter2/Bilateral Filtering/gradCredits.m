%% Grad credits: edge preserving smoothing

% Load test images.
% Note: Must be double precision in the interval [0,1].
imbila = double(imread('lena_noisy.png'))/255;

% Introduce AWGN into test images.
% Note: This will show the benefit of bilateral filtering.
imbila = imbila+0.03*randn(size(imbila));
imbila(imbila<0) = 0; imbila(imbila>1) = 1;

% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigmaLarge = [3 1000]; % bilateral filter standard deviations very large
sigmaSmall = [3 0.001]; % bilateral filter standard deviations very small
sigma001 = [3, 0.01]; % set the sd to 0.01
sigma01 = [3, 0.1]; % set the sd to 0.1
sigma1 = [3, 1]; % set the sd to 1
sigma10 = [3, 10]; % set the sd to 10
sigma100 = [3, 100]; % set the sd to 100

% Apply bilateral filter to each image.
bflt_imbilaLarge = bfilter2(imbila,w,sigmaLarge);
imwrite(bflt_imbilaLarge, 'sigmaLargelena.png');
bflt_imbilaSmall = bfilter2(imbila,w,sigmaSmall);
imwrite(bflt_imbilaSmall, 'sigmaSmalllena.png');
bflt_imbila001 = bfilter2(imbila,w,sigma001);
imwrite(bflt_imbila001, 'sigma001lena.png');
bflt_imbila01 = bfilter2(imbila,w,sigma01);
imwrite(bflt_imbila01, 'sigma01lena.png');
bflt_imbila1 = bfilter2(imbila,w,sigma1);
imwrite(bflt_imbila1, 'sigma1lena.png');
bflt_imbila10 = bfilter2(imbila,w,sigma10);
imwrite(bflt_imbila10, 'sigma10lena.png');
bflt_imbila100 = bfilter2(imbila,w,sigma100);
imwrite(bflt_imbila100, 'sigma100lena.png');

% Display grayscale input image and filtered output.
figure(1); clf;
set(gcf,'Name','Grayscale Bilateral Filtering Results');
subplot(1,3,1); imagesc(imbila);
axis image; colormap gray;
title('Input Image');
subplot(1,3,2); imagesc(bflt_imbilaLarge);
axis image; colormap gray;
title('Bilateral Filtering Large');
subplot(1,3,3); imagesc(bflt_imbilaSmall);
axis image; colormap gray;
title('Bilateral Filtering Small');
