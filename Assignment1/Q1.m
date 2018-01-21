im1 = imread('tiger.jpg');
crop1 = imcrop(im1);
imwrite(crop1, 'tigercrop.PNG');
im_red = crop1(:, :, 1);
im_green = crop1(:, :, 2);
im_blue = crop1(:, :, 3);
crop1(:, :, 1) = im_red;
crop1(:, :, 2) = 0;
crop1(:, :, 3) = 0;
imshow(crop1);
pause;

imgR = im1(:, :, 1);
imgG = im1(:, :, 2);
imgB = im1(:, :, 3);
im2(:, :, 1) = imgG;
im2(:, :, 2) = imgR;
im2(:, :, 3) = imgB;
imshow(im2);