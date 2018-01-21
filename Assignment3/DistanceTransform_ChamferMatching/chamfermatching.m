%% Exhaustive search

im1 = imread('cow.png');
imgray = rgb2gray(im1);
cannyedge = edge(imgray, 'Canny');
imeuclidean = uint8(bwdist(cannyedge, 'euclidean'));

imtemp = imread('template.png');
edgeindex = find(imtemp == 1);

minsum = Inf;
startI = 0;
startJ = 0;

[rowdist, coldist] = size(imeuclidean);
[rowtemp, coltemp] = size(imtemp);

rowend = rowdist - rowtemp + 1;
colend = coldist - coltemp + 1;

for i = 1 : rowend
    for j = 1 : colend
        subim = imeuclidean(i : (i + rowtemp - 1), j : (j + coltemp - 1));
        currsum = sum(subim(edgeindex));
        if (currsum < minsum)
            minsum = currsum;
            startI = i;
            startJ = j;
        end
    end
end

minchamferdist = minsum / length(edgeindex);
disp(minchamferdist);

disp(startI);
disp(startJ);

%% Superimpose the temp on the cow image
for i = 1 : rowtemp
    for j = 1 : coltemp
        if (imtemp(i, j) == 1)
            im1(i + startI - 1, j + startJ - 1, 2) = 0;
            im1(i + startI - 1, j + startJ - 1, 3) = 0;
        end
    end
end

imshow(im1);
imwrite(im1, 'matchingcow.png');