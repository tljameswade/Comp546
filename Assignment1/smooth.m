imSmooth = imread('lena_noisy.png');

boxfilt1 = fspecial('average', 2);
boxfilt2 = fspecial('average', 4);
boxfilt3 = fspecial('average', 8);
boxfilt4 = fspecial('average', 16);

boxIm1 = imfilter(imSmooth, boxfilt1);
imshow(boxIm1);
pause;

boxIm2 = imfilter(imSmooth, boxfilt2);
imshow(boxIm2);
pause;

boxIm3 = imfilter(imSmooth, boxfilt3);
imshow(boxIm3);
pause;

boxIm4 = imfilter(imSmooth, boxfilt4);
imshow(boxIm4);
pause;

gausfilt1 = fspecial('gaussian', 8, 2);
gausfilt2 = fspecial('gaussian', 16, 4);
gausfilt3 = fspecial('gaussian', 32, 8);
gausfilt4 = fspecial('gaussian', 64, 16);

gausIm1 = imfilter(imSmooth, gausfilt1);
imshow(gausIm1);
pause;

gausIm2 = imfilter(imSmooth, gausfilt2);
imshow(gausIm2);
pause;

gausIm3 = imfilter(imSmooth, gausfilt3);
imshow(gausIm3);
pause;

gausIm4 = imfilter(imSmooth, gausfilt4);
imshow(gausIm4);
pause;
