%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HW1
% Author: Suozhi Qi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Part I

%% Exercise 1

%% Read the image
im1 = imread('tiger.jpg');

%% Crop the image based on selection
crop1 = imcrop(im1);

%% Save the cropped image to a PNG file
imwrite(crop1, 'tigercrop.PNG');

%% Display the red component of the image
im_red = crop1(:, :, 1);
im_green = crop1(:, :, 2);
im_blue = crop1(:, :, 3);
crop1(:, :, 1) = im_red;
crop1(:, :, 2) = 0;
crop1(:, :, 3) = 0;
imshow(crop1);
imwrite(crop1, 'redhead.PNG');

%% Change the order of the color components to [Green,Red,Blue] for the original image and display the image.
imgR = im1(:, :, 1);
imgG = im1(:, :, 2);
imgB = im1(:, :, 3);
imchage(:, :, 1) = imgG;
imchange(:, :, 2) = imgR;
imchange(:, :, 3) = imgB;
imshow(imchange);
imwrite(imchange, 'colorChanged.PNG');

%% Exercise 2

%% Read the image and convert to gray scale
im2 = imread('barbara.jpg');
im2gray = rgb2gray(im2);
imwrite(im2gray, 'barbaraGray.PNG');

%% Blur the gray scale image by using a Gaussian filter of size 5 X 5 with standard deviation 2.
gaussFilt = fspecial('gaussian', 5, 2);
convIm = imfilter(im2gray, gaussFilt, 'symmetric');
imshow(convIm);
imwrite(convIm, 'gaussianFilterBarbara.PNG');

%% Subtract the blurred image from the original gray scale image.
subIm1 = imsubtract(im2gray, convIm);
imshow(subIm1);
imwrite(subIm1, 'subtractBarbara.PNG');

%% Threshold the resultant image at 5% of its maximum pixel value.
maxPixelVal = max(max(convIm));
thresh = 0.05 * maxPixelVal;
tIm1 = subIm1;
index = find(tIm1<=thresh);
tIm1(index) =  0;
imwrite(tIm1, 'thresholdBarbara.PNG');

%% Display the thresholded image
imshow(tIm1);



%% Part II

%% Filtering

%% Filter manually the following matrices I1 and I2
I1 = [125 130 120 110 50;140 130 130 60 35;125 110 50 35 20;80 40 40 20 10;35 30 20 5 5];
I2 = [125 130 120 110 125;140 130 130 100 120;65 60 55 50 40;35 30 40 20 10;15 10 20 5 5];

f1 = 1 / 3 * [1 1 1];
f2 = 1 / 3 * [1;1;1];
f3 = 1 / 9 * [1 1 1;1 1 1;1 1 1];

filt11 = imfilter(I1, f1);
filt12 = imfilter(I1, f2);
filt13 = imfilter(I1, f3);
filt21 = imfilter(I2, f1);
filt22 = imfilter(I2, f2);
filt23 = imfilter(I2, f3);

disp(filt11);
disp(filt12);
disp(filt13);
disp(filt21);
disp(filt22);
disp(filt23);

%% Apply following filters on the gray scale image of barbara from Part I
% 1. Central difference Gradient filter
% x-axis filter
centralXFilt = 1/2 * [-1, 0, 1];
% y-axis filter
centralYFilt = 1/2 * [-1; 0; 1];
centralX = double(imfilter(im2gray, centralXFilt))/ 255;
centralY = double(imfilter(im2gray, centralYFilt)) /255;
imshow(centralX);
imwrite(centralX, 'centralX.PNG');
imshow(centralY);
imwrite(centralY, 'centralY.PNG');
% collective filter
central = sqrt(centralX.*centralX + centralY.*centralY);
imshow(central);
imwrite(central, 'centralDiff.PNG');

% 2. Sobel filter
filtSob = fspecial('sobel');
imSob = imfilter(im2gray, filtSob);
imshow(imSob);
imwrite(imSob, 'sobBarbara.PNG');

% 3. Mean filter
filtMean = fspecial('average');
imMean = imfilter(im2gray, filtMean);
imshow(imMean);
imwrite(imMean, 'meanBarbara.PNG');

% 4. Median filter
imMed = medfilt2(im2gray);
imshow(imMed);
imwrite(imMed, 'medBarbara.PNG');

%% Smoothing

%% Read the image `lena noisy.png'
imSmooth = imread('lena_noisy.png');

%% Box (averaging) filters of sizes 2 X 2;4 X 4;8 X 8;16 X 16
boxfilt1 = fspecial('average', 2);
boxfilt2 = fspecial('average', 4);
boxfilt3 = fspecial('average', 8);
boxfilt4 = fspecial('average', 16);

boxIm1 = imfilter(imSmooth, boxfilt1);
imshow(boxIm1);
imwrite(boxIm1, 'box1lena.PNG');

boxIm2 = imfilter(imSmooth, boxfilt2);
imshow(boxIm2);
imwrite(boxIm2, 'box2lena.PNG');

boxIm3 = imfilter(imSmooth, boxfilt3);
imshow(boxIm3);
imwrite(boxIm3, 'box3lena.PNG');

boxIm4 = imfilter(imSmooth, boxfilt4);
imshow(boxIm4);
imwrite(boxIm4, 'box4lena.PNG');

%% Gaussian filter of standard deviations 2, 4, 8, 16
gausfilt1 = fspecial('gaussian', 8, 2);
gausfilt2 = fspecial('gaussian', 16, 4);
gausfilt3 = fspecial('gaussian', 32, 8);
gausfilt4 = fspecial('gaussian', 64, 16);

gausIm1 = imfilter(imSmooth, gausfilt1, 'symmetric');
imshow(gausIm1);
imwrite(gausIm1, 'gaus1lena.PNG');

gausIm2 = imfilter(imSmooth, gausfilt2, 'symmetric');
imshow(gausIm2);
imwrite(gausIm2, 'gaus2lena.PNG');

gausIm3 = imfilter(imSmooth, gausfilt3, 'symmetric');
imshow(gausIm3);
imwrite(gausIm3, 'gaus3lena.PNG');

gausIm4 = imfilter(imSmooth, gausfilt4, 'symmetric');
imshow(gausIm4);
imwrite(gausIm4, 'gaus4lena.PNG');




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
