function result = dpScan(leftImg, rightImg, rowIndex, patchSize)

[row,col] = size(leftImg);
shift = (patchSize - 1) / 2;

disparity = zeros(col);
dp = zeros(col);
result = zeros(1,col);

% These two new matrixes prevent the indexes from going out of bounds
leftHelper = zeros(row + 2 * shift, col + 2 * shift);
leftHelper(shift + 1 : row + shift, shift + 1 : col + shift) = leftImg;
rightHelper = zeros(row + 2 * shift, col + 2 * shift);
rightHelper(shift + 1 :row + shift, shift + 1 : col + shift) = rightImg;

for i =1 : col
    coord = [rowIndex + shift, i + shift];
    for j = 1 : col
        leftMatch = (leftHelper(coord(1) - shift: coord(1) + shift, coord(2) - shift: coord(2)+ shift));
        rightMatch = (rightHelper(coord(1) - shift: coord(1) + shift, j : j + 2 * shift));
        disparity(i, j) = sqrt(sum(sum(leftMatch - rightMatch).^2));
    end;
end;

% Store the dp value and find the minimum path
dp(1, 1) = disparity(1, 1);
for j = 2 : col
    dp(1, j) = dp(1, j - 1) + disparity(1, j);
    dp(j, 1) = dp(j - 1, 1) + disparity(1, j);
end
for i = 2 : col
    for j = 2 : col
        dp(i, j) = min([dp(i - 1, j),dp(i - 1,j - 1),dp(i, j - 1)]) + disparity(i, j);
    end
end

currIndex = col;
result(currIndex) = 0;
j = col;
while j > 1
    if currIndex == 1
        result(j - 1) = j - 1;
        j = j - 1;
    else
        temp = min([dp(j, currIndex - 1),dp(j - 1, currIndex),dp(j - 1, currIndex - 1)]);
        if (temp == dp(j, currIndex - 1))
            currIndex = currIndex - 1;
        elseif (temp == dp(j - 1, currIndex))
                result(j - 1) = j + 1 - currIndex;
                j = j - 1;
        else
            result(j - 1) = j - currIndex;
            currIndex = currIndex - 1;
            j = j - 1;
        end
    end
end