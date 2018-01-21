im2 = imread('barbara.jpg');
im2gray = rgb2gray(im2);

gaussFilt = fspecial('gaussian', 5, 2);
convIm = imfilter(im2gray, gaussFilt);

maxPixelVal = max(max(convIm));

thresh = 0.05 * maxPixelVal;

tIm1 = imsubtract(im2gray, convIm);

index = find(tIm1<=thresh);
tIm1(index) =  0;
imshow(tIm1);

