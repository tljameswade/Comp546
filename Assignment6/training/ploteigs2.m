% Plots gpcavects (2 gradients)
% Direction is either 1 (x grad) or 2 (y grad)
function ploteigs2(P, direction)

if nargin < 1
   error( 'Not enough input arguments.' );
end

cols = floor(sqrt(size(P, 2)));
rows = floor(size(P, 2) / cols);

hsize = size(P, 1) / 2;
sq = sqrt(hsize);

scale = 5;
tmax = 0;

for (m = 1:rows)
    for (n = 1:cols)
        index = (m - 1)*cols + n;
        subplot(rows, cols, index);
        T = reshape(P(direction:2:end, index), sq, sq);
        tmax = max([max(max(abs(T))) tmax]);
        imshow(T * scale + 0.5);
    end
end
