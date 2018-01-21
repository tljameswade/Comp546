clear PCAfeatureY;
%% Get the U
U = zeros(R, K);
sumK = 0;
for i = 1 : K
    U(:, i) = eigenvectors(:, eigenIndex(i));
    sumK = sumK + eigenvalues(eigenIndex(i));
end

%% Extract PCA features
PCAfeatureY(1:40, 1:1) = struct();
for i = 1 : 40
    temp = [];
    for j = 1 : 5
        indivImg = im2double(trainingImg(i, j).Image);
        eachImgVect = reshape(indivImg', R, 1);
        temp = [temp U' * eachImgVect];
    end
    PCAfeatureY(i, 1).(matlab.lang.makeValidName('subVec')) = temp;
end

%% Testing phase
correctPredict = 0;
for i = 1 : 40
    for j = 1 : 5
        eachTestImg = testingImg(i, j).Image;
        eachTestImg = im2double(eachTestImg); 
        indivImgVec = reshape(eachTestImg', R, 1);
        indivTestY = U' * indivImgVec;
        dist = [];
        for k = 1 : 40
            trainingY = PCAfeatureY(k, 1).subVec;
            subTotalDist = 0;
            for m = 1 : 5
                dis = norm(indivTestY - trainingY(:, m));
                subTotalDist = subTotalDist + dis;
            end
            dist = [dist subTotalDist];
        end
        [~, testIndex] = sort(dist);
        if testIndex(1) == i
            correctPredict = correctPredict + 1;
        end       
    end
end

identiPercent = correctPredict / 200;