%% "Cornerness" measure

% Convert to gray scale
imchessboard = imread('chessboard.jpg');
chessboardcopy = imchessboard;
imchessboardgray = rgb2gray(imchessboard);
imwrite(imchessboardgray, 'imchessboardgray.png');

% Compute Ix and Iy
FiltX = 1/2 * [-1, 0, 1];
FiltY = 1/2 * [-1; 0; 1];

imIx = double(imfilter(imchessboardgray, FiltX))/ 255;
imwrite(imIx, 'chessboardIx.png');
imIy = double(imfilter(imchessboardgray, FiltY))/ 255;
imwrite(imIy, 'chessboardIy.png');

% Compute Ix * Ix, Iy * Iy, Ix*Iy
imIx2 = imIx.*imIx;
imIy2 = imIy.*imIy;
imIxIy = imIx.*imIy;

% Create a Gaussian filter
filtG = fspecial('gaussian', [8, 8], 2);

% Apply the Gaussian filter
imIx2filt = imfilter(imIx2, filtG);
imshow(imIx2filt);
imwrite(imIx2filt, 'chessboardIx2.png');
imIy2filt = imfilter(imIy2, filtG);
imshow(imIy2filt);
imwrite(imIy2filt, 'chessboardIy2.png');
imIxIyfilt = imfilter(imIxIy, filtG);
imshow(imIxIyfilt);
imwrite(imIxIyfilt, 'chessboardIxIy.png')

% Compute the cornerness M
determinant = imIx2filt.*imIy2filt - imIxIyfilt.* imIxIyfilt;
trace = imIx2filt + imIy2filt;
imM = 50 * determinant ./ (trace + 0.000000000000001);
imM = im2uint8(imM);
imwrite(imM, 'cornerness.png');

%% Corner extraction

% Perform non-max suppression of M
immax = ordfilt2(imM, 625, ones(25, 25));
cornerdetect = (immax == imM & imM > 30);
imwrite(cornerdetect, 'cornerdetect.png');

% Find the coordinates of the corner points
[lx, ly] = find(cornerdetect == 1);
disp(lx);
disp(ly);

% Display the image and superimpose
cornerdetect = imdilate(cornerdetect, strel('disk', 3));
imshow(cornerdetect);
corner = uint8(~cornerdetect);
imchessboard(:,:,1) = imchessboard(:,:,1) .* corner;
imchessboard(:,:,2) = imchessboard(:,:,2) .* corner;
imshow(imchessboard);
imwrite(imchessboard, 'superimpose.png');


%% Rotate and Scaling

imrotateboard = imrotate(chessboardcopy, 30);
imwrite(imrotateboard, 'rotateimg.png');
rotateimpose = Harris_detector(imrotateboard);
imwrite(rotateimpose, 'rotateimpose.png');
imresizeboard = imresize(chessboardcopy, 4);
imwrite(imresizeboard, 'resizeimg.png');
resizeimpose = Harris_detector(imresizeboard);
imwrite(resizeimpose, 'resizeimpose.png');
