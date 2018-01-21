function ploteigs(P)

if nargin < 1
   error( 'Not enough input arguments.' );
end

cols = floor(sqrt(size(P, 2)));
rows = floor(size(P, 2) / cols);

sq = sqrt(size(P, 1));

for (m = 1:rows)
    for (n = 1:cols)
        index = (m - 1)*cols + n;
        subplot(rows, cols, index);
        T = reshape(P(:, index), sq, sq);
        imshow(T * 3 + 0.5);
    end
end
