
%% Load images
trainingDir = './Assignment06_data/Assignment06_data_reduced/TrainingDataset/';
% Get the subfolders of the training dataset
trainingClasses = dir(trainingDir);
trainingClasses = trainingClasses(4 : end);

% Create an image data store for the training set images
reducedImds = imageDatastore(trainingDir, 'IncludeSubfolders', true, 'FileExtensions', '.jpg', 'LabelSource', 'foldernames');
% Get the bag of features from the training set images
reducedBOFeature = bagOfFeatures(reducedImds);

%% Train SVM
trainingPred = [];
trainingLabel = [];
for i = 1: length(trainingClasses)
    indivClassDir = dir(strcat(trainingDir, trainingClasses(i).name, '/*.jpg'));
    for j = 1: length(indivClassDir)
        indivImg = imread(strcat(trainingDir, trainingClasses(i).name, '/', indivClassDir(j).name));
        trainingPred = [trainingPred; encode(reducedBOFeature, indivImg)];
        trainingLabel = [trainingLabel; i];
    end
end

% The model from training SVM
Mdl = fitcecoc(trainingPred, trainingLabel);

%% Test reduced dataset
testPred = [];
testLabel = [];
testingDir = './Assignment06_data/Assignment06_data_reduced/TestDataset_';
for i = 1: length(trainingClasses)
    indivTestDir = dir(strcat(testingDir, num2str(i), '/*.jpg'));
    for j = 1: length(indivTestDir)
        indivTestImg = imread(strcat(testingDir, num2str(i), '/', indivTestDir(j).name));
        testPred = [testPred; encode(reducedBOFeature, indivTestImg)];
        testLabel = [testLabel; i];
    end
end

% Predicted classes(label) based on the trained model above
predLabel = predict(Mdl, testPred);
% Get the count of each prediction and store into reducedCount
reducedCount = zeros(length(trainingClasses));
for i = 1 : length(predLabel)
    reducedCount(testLabel(i), predLabel(i)) = reducedCount(testLabel(i), predLabel(i)) + 1;
end

% Get the results of the proportion by division in the reducedCount matrix
reducedRes = zeros(length(trainingClasses));
for i = 1 : length(reducedCount)
    reducedRes(i, :) = reducedCount(i, :) / sum(reducedCount(i, :));
end
disp(reducedRes);