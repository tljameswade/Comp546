im = imread('barbaraGray.PNG');
centralXFilt = [-1, 0, 1];
centralYFilt = [-1; 0; 1];
centralX = double(imfilter(im, centralXFilt))/ 255;
centralY = double(imfilter(im, centralYFilt)) /255;
figure(1);
imshow(centralX);
figure(2);
imshow(centralY);
central = sqrt(centralX.*centralX + centralY.*centralY);
figure(3);
imshow(central);