%% 1.1 Ransac for line fitting
allcandidates = load('LineData.mat');
data = cat(1, allcandidates.x, allcandidates.y);
num = 2;
iter = 100;
threshDist = 0.3;
inlierRatio = 0.5;
p = 0.9999;
ransac_demo(data,num,iter,threshDist,inlierRatio);
N = log(1 - p) / log(1 - inlierRatio * inlierRatio);
disp(N);
