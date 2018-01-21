%% Use the adaptive procedure in RANSAC algorithm to find the parameters

e = 0.5;
s = 3;
t = 0.7;
p = 0.9999;
N = ceil(log(1 - p) / log(1 - power((1 - e), s)));
candidateX = zeros(2, 3);
inlierscount = 0;

affinedata = load('AffineData.mat.mat');
origf = affinedata.orig_feature_pt;
transf = affinedata.trans_feature_pt;

% adaptive procedure
sample_count = 0;

while N > sample_count
    A = zeros(6, 6);
    b = zeros(6, 1);
    candidatept = randperm(size(origf, 2), s);
    for i = 1 : s
        num = candidatept(i);
        xA = origf(1, num);
        yA = origf(2, num);
        xb = transf(1, num);
        yb = transf(2, num);
        A(i * 2 - 1, 1) = xA;
        A(i * 2 - 1, 2) = yA;
        A(i * 2 - 1, 3) = 1;
        A(i * 2, 4) = xA;
        A(i * 2, 5) = yA;
        A(i * 2, 6) = 1;
        b(i * 2 - 1, 1) = xb;
        b(i * 2, 1) = yb;
    end
    
    x = A\b;
    x = cat(1, transpose(x(1:3 ,:)), transpose(x(4: 6,:)));
    calcdist = [];
    onearray = ones(1, size(origf, 2));
    transformed = cat(1, origf, onearray);
    distarray = transf - x * transformed;

    for j = 1 : length(transformed)
        calcdist(end + 1) = sqrt(sumsqr(distarray(:, j)));
    end
    
    curr_inliers = find (calcdist <= t);
    
    if (inlierscount < length(curr_inliers))
        inlierscount = length(curr_inliers);
        candidateX = x;
        e = 1 - inlierscount / size(origf, 2);
        N = ceil(log(1 - p) / log(1 - power((1 - e), s)));
    end
    sample_count = sample_count + 1;
end

disp(sample_count);
disp(e);
disp(N);
disp(candidateX);

origim = imread('castle_original.png');
A = transpose(cat(1, candidateX, [0,0,1]));
disp(A);
tform = maketform('affine', A);
newim = imtransform(origim, tform);
imshow(newim);
imwrite(newim,'transformedim.png');
