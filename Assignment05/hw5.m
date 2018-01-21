%% Solving Correspondence

im1 = imread('tsukuba_l.ppm');
im2 = imread('tsukuba_r.ppm');

im1 = im2double(rgb2gray(im1));
im2 = im2double(rgb2gray(im2));
patchSize = 23;
[row, col] = size(im1);

 
% Coord of each the 6 given pixels
p1 = [136, 83];
p2 = [203, 304];
p3 = [182, 119];
p4 = [186, 160];
p5 = [123, 224];
p6 = [153, 338];
 
% Calculate the profile pic of the 6 given pixel points
[maxcorr1, leftMatch1, line1, index1] = getMatch(im1, im2, p1, patchSize);
figure
plot(1 - p1(2) : size(line1, 2) - p1(2), line1)
title('P1','FontSize', 20)
xlabel('Delta','FontSize',14)
ylabel('Normalized Correlation', 'FontSize', 14);
 
[maxcorr2, leftMatch2, line2, index2] = getMatch(im1, im2, p2, patchSize);
figure
plot(1 - p2(2) : size(line2, 2) - p2(2), line2)
title('P2','FontSize', 20)
xlabel('Delta','FontSize',14)
ylabel('Normalized Correlation', 'FontSize', 14);
 
[maxcorr3, leftMatch3, line3, index3] = getMatch(im1, im2, p3, patchSize);
figure
plot(1 - p3(2) : size(line3, 2) - p3(2), line3)
title('P3','FontSize', 20)
xlabel('Delta','FontSize',14)
ylabel('Normalized Correlation', 'FontSize', 14);
 
[maxcorr4, leftMatch4, line4, index4] = getMatch(im1, im2, p4, patchSize);
figure
plot(1 - p4(2) : size(line4, 2) - p4(2), line4)
title('P4','FontSize', 20)
xlabel('Delta','FontSize',14)
ylabel('Normalized Correlation', 'FontSize', 14);
 
[maxcorr5, leftMatch5, line5, index5] = getMatch(im1, im2, p5, patchSize);
figure
plot(1 - p5(2) : size(line5, 2) - p5(2), line5)
title('P5','FontSize', 20)
xlabel('Delta','FontSize',14)
ylabel('Normalized Correlation', 'FontSize', 14);
 
[maxcorr6, leftMatch6, line6, index6] = getMatch(im1, im2, p6, patchSize);
figure
plot(1 - p6(2) : size(line6, 2) - p6(2), line6)
title('P6','FontSize', 20)
xlabel('Delta','FontSize',14)
ylabel('Normalized Correlation', 'FontSize', 14);


% Get disparity map
threshold = 0.55;
dispMap = NaN(size(im1));
for i = 1 : size(im1, 1)
    for j = 1 : size(im1, 2)
        coord = [i, j];
        [maxcorr, leftMatch, line, index] = getMatch(im1, im2, coord, patchSize);
        if ((maxcorr >= threshold) && (abs(index) <= 20))
            dispMap(i, j) = index;
        end
    end
end
 
figure
colormap('hot')
imagesc(dispMap)
colorbar
 
% Fill in undefined values
fulldispMap = inpaint_nans(dispMap, 2);
figure
colormap('hot')
imagesc(fulldispMap)
colorbar

%% Dynamic programming of scan
dpMap = NaN(row, col);
for i = 1 : row
    dpMap(i, :) = dpScan(im1, im2, i, patchSize);
end;

figure
colormap('hot')
imagesc(dpMap)
colorbar