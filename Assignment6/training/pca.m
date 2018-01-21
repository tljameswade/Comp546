function [meanvec, P] = pca(fn, numcomps)
patchsize = 41;
patchlen = patchsize*patchsize;

if nargin < 2
   error( 'Not enough input arguments.' );
end

disp('Reading patch file.');

fid = fopen(fn, 'r');
array = fscanf(fid, '%d', [patchlen, inf]);

disp('Computing covariance matrix');
meanvec = mean(array, 2);
meanarray = repmat(meanvec, 1, size(array,2));
A = array-meanarray;
covA = A*A';

disp('Computing principle components.');
[V, D] = eig(covA);

P = V(:, (size(V, 2) - numcomps + 1) : size(V, 2));
P = fliplr(P);

figure(3);
plot(flipud(diag(D)));
