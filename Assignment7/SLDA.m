clear;

%% Vectorize and Sw calculation
allFaceImg = load('faceDat.mat');
allFaceImg = allFaceImg.faceDat;

trainingImg = allFaceImg(:, 1:5);
testingImg = allFaceImg(:, 6:10);
[row, col] = size(testingImg(1, 1).Image);
R = row * col;
Sw = zeros(R, R);
trainingVector(1: 40, 1: 1) = struct();
allVect = [];
mean_subject = [];

for i = 1 : 40
    % The vector for each subject
    subjectVect = [];
    for j = 1 : 5
        % For each individual image
        indivImg = im2double(trainingImg(i, j).Image);
        % Vectorize each individual face image 
        eachImgVect = reshape(indivImg', R, 1);
        subjectVect = [subjectVect eachImgVect];
        % Put each image vector to the allVect matrix
        allVect = [allVect eachImgVect];
    end
    meanSub = mean(subjectVect, 2);
    temp = subjectVect - repmat(meanSub, 1, 5);
    temp = temp * temp';
    Sw = Sw + temp;
    mean_subject = [mean_subject meanSub];
    % Put each subject vector to the training vector struct
    trainingVector(i, 1).(matlab.lang.makeValidName('subjectVec')) = subjectVect;
end

%% Sb calculation
meanOverall = mean(allVect, 2);
Sb = zeros(R, R);
for i  = 1 : 40
    Sb = Sb + 5 * (mean_subject(:,i) - meanOverall) * (mean_subject(:,i) - meanOverall)';
end

%% Get the Eigenfaces
[eigenvectors, eigenvalues] = eig(pinv(Sw) * Sb);
eigenvalues = diag(eigenvalues);
[~, eigenIndex] = sort(eigenvalues, 'descend');
sumeigenValues = sum(eigenvalues);

K = 20;
figure(1)
for i = 1 : K
    eigenIndivVec = eigenvectors(:, eigenIndex(i));
    eigenIndivImg = 15 * reshape(eigenIndivVec, col, row)';
    subplot(4, 5, i);
    imshow(eigenIndivImg);
end

%% Plot Id percent versus K
K_val = [];
Id_val = [];
for i = 5 : 5 : 1000
    K_val = [K_val i];
    K = i;
    getidentiPercent;
    Id_val = [Id_val identiPercent];
end
figure(2)
plot(K_val, Id_val)
title('Tasks1.2', 'FontSize', 18)
xlabel('PCA dimensionality K', 'FontSize', 15)
ylabel('Identication Percentage', 'FontSize', 15);

%% Generate table columns
K_value = [5,10,20,40,60,100,150,200,400,1000,2000];
res = [];
for i = 1 : length(K_value)
    K = K_value(i);
    getidentiPercent;
    eachCol = [K; sumK / sumeigenValues; identiPercent];
    res = [res eachCol];
end
res = res';