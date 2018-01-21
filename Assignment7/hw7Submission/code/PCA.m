clear;

%% Vectorize
allFaceImg = load('faceDat.mat');
allFaceImg = allFaceImg.faceDat;

trainingImg = allFaceImg(:, 1:5);
testingImg = allFaceImg(:, 6:10);
[row, col] = size(testingImg(1, 1).Image);
R = row * col;
trainingVector(1: 40, 1: 1) = struct();
allVect = [];

for i = 1 : 40
    % The vector for each subject
    subjectVec = zeros(R, 5);
    for j = 1 : 5
        % For each individual image
        indivImg = im2double(trainingImg(i, j).Image);
        % Vectorize each individual face image 
        eachImgVect = reshape(indivImg', R, 1);
        subjectVec(:, j) = eachImgVect;
        % Put each image vector to the allVect matrix
        allVect = [allVect eachImgVect];
    end
    % Put each subject vector to the training vector struct
    trainingVector(i, 1).(matlab.lang.makeValidName('subjectVec')) = subjectVec;
end

%% S calculation
m = mean(allVect, 2);
 
A = [];
for i=1 : size(allVect, 2)
    temp = double(allVect(:,i)) - m;
    A = [A temp];
end
S = A * A';

%% Get the Eigenfaces
[eigenvectors, eigenvalues] = eig(S);
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
for i = 5 : 5 : 2500
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