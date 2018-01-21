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

im2 = imread('barbara.jpg');
im2gray = rgb2gray(im2);
imshow(im2gray);

