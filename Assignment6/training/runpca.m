function runpca(fn)

numcomps = 36;

if nargin < 1
   error( 'Not enough input arguments.' );
end

[avg, P] = pcag(fn, numcomps);

save -ascii 'gpcavects.txt' avg P;

ploteigs(P);
