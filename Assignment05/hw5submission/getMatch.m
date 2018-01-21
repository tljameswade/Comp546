%% The function to get the line correlation for each pixel point
function [maxcorr, leftMatch, line, index] = getMatch(leftImg, rightImg, coord, patchSize)
leftSize = size(leftImg);
rightSize = size(rightImg);
shift = (patchSize - 1) / 2;

leftMatch = leftImg(max((coord(1) - shift), 1) : min((coord(1) + shift), leftSize(1)),...
    max((coord(2) - shift), 1) : min((coord(2) + shift), leftSize(2)));
rightMatch = rightImg(max((coord(1) - shift), 1) : min((coord(1) + shift), rightSize(1)),...
    :);

patchMatch = normxcorr2(leftMatch, rightMatch);
lineMatch = patchMatch(patchSize, :);
line = lineMatch(1 + shift : size(lineMatch, 2) - shift);
[maxcorr, index] = max(lineMatch);
index = index - coord(2);