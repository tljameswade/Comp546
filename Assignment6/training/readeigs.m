% n = size of patch (eg. 39, which makes 39x39 length vector)

function [M, P] = readeigs(fn, n)

fid = fopen(fn, 'r');

M = fscanf(fid, '%f', [n*n, 1]);

if (size(keys, 2) ~= numkeys)
        disp('Error reading file.');
end

