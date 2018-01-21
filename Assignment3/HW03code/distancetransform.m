%% Draw the canny edge image
im1 = imread('cow.png');
im1 = rgb2gray(im1);
cannyedge = edge(im1, 'Canny');
imshow(cannyedge);
imwrite(cannyedge, 'cannyedge.png');

%% Compute L1 distance and display the results

[sizeX, sizeY] = size(cannyedge);
grid = Inf(sizeX, sizeY);

for i = 1 : sizeX
    
    % Forward
    currmin = Inf;
    for j = 1 : sizeY
        if (cannyedge(i, j) == 1)
            currmin = 0;
        else
            currmin = currmin + 1;
        end
        if (grid(i, j) > currmin)
            grid(i, j) = currmin;
        end
    end
    
    % Backward
    currmin = Inf;
    for j = sizeY : -1 : 1
        if (cannyedge(i, j) == 1)
            currmin = 0;
        else
            currmin = currmin + 1;
        end
        if (grid(i, j) > currmin)
            grid(i, j) = currmin;
        end
    end
end


for j = 1 : sizeY
    
    % Downward
    currmin = Inf;
    for i = 1 : sizeX
        if (currmin + 1 > grid(i, j))
            currmin = grid(i, j);
        else
            currmin = currmin + 1;
        end
        if (grid(i, j) > currmin)
            grid(i, j) = currmin;
        end
    end
    
    % Upward
    currmin = Inf;
    for i = sizeX : -1 : 1
        if (currmin + 1 > grid(i, j))
            currmin = grid(i, j);
        else 
            currmin = currmin + 1;
        end
        if (grid(i, j) > currmin)
            grid(i, j) = currmin;
        end
    end
end

grid = uint8(grid);
imshow(grid);
imwrite(grid, 'chamfercow.png');

%% Computer different distance transforms using cow edge map
imchessboard = uint8(bwdist(cannyedge, 'chessboard'));
imshow(imchessboard);
imwrite(imchessboard, 'chessboardtrans.png');
imcityblock = uint8(bwdist(cannyedge, 'cityblock'));
imshow(imcityblock);
imwrite(imcityblock, 'cityblocktrans.png');
imeuclidean = uint8(bwdist(cannyedge, 'euclidean'));
imshow(imeuclidean);
imwrite(imeuclidean, 'euclideantrans.png');