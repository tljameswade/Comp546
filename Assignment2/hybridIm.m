lowpassfilt = fspecial('gaussian', 11, 8.5);
lowpassfilt1 = fspecial('gaussian', 80, 45);

im1 = imread('james.jpg');
im1 = rgb2gray(im1);
im1 = im1/1.5; % Adjust the pixel intensity globally
im2 = imread('jing.jpg');
im2 = rgb2gray(im2);

lowpassim = imfilter(im1, lowpassfilt);
figure(1)
imshow(lowpassim);
highpassim = imfilter(im2, lowpassfilt1);
highpassim = im2 - highpassim; % high pass filtered image is generated by an impulse minus low pass filted image
figure(2)
imshow(highpassim);
im3 = lowpassim + highpassim;
imwrite(lowpassim, 'james1.jpg');
imwrite(highpassim, 'jing1.jpg');
figure(3)
imshow(im3);
imwrite(im3, 'hybrid.jpg');