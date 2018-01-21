function [imposeim] = Harris_detector(oriimg)

imchessboardgray = rgb2gray(oriimg);
% Compute Ix and Iy
FiltX = 1/2 * [-1, 0, 1];
FiltY = 1/2 * [-1; 0; 1];

imIx = double(imfilter(imchessboardgray, FiltX))/ 255;
imIy = double(imfilter(imchessboardgray, FiltY))/ 255;

% Compute Ix * Ix, Iy * Iy, Ix*Iy
imIx2 = imIx.*imIx;
imIy2 = imIy.*imIy;
imIxIy = imIx.*imIy;

% Create a Gaussian filter
filtG = fspecial('gaussian', [8, 8], 2);

% Apply the Gaussian filter
imIx2filt = imfilter(imIx2, filtG);
imIy2filt = imfilter(imIy2, filtG);
imIxIyfilt = imfilter(imIxIy, filtG);

% Compute the cornerness M
determinant = imIx2filt.*imIy2filt - imIxIyfilt.* imIxIyfilt;
trace = imIx2filt + imIy2filt;
imM = 50 * determinant ./ (trace + 0.000000000000001);
imM = im2uint8(imM);

%% Corner extraction

% Perform non-max suppression of M
immax = ordfilt2(imM, 625, ones(25, 25));
cornerdetect = (immax == imM & imM > 30);

% Return the super imposed image
cornerdetect = imdilate(cornerdetect, strel('disk', 3));
corner = uint8(~cornerdetect);
oriimg(:,:,1) = oriimg(:,:,1) .* corner;
oriimg(:,:,2) = oriimg(:,:,2) .* corner;
imposeim = oriimg;

