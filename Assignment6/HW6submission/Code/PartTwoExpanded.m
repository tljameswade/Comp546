% Get the directory of the training data set
trainingDir = './Assignment06_data/Assignment06_data_expanded/TrainingDataset';
% Construct the image data store
imgDataStore = imageDatastore(trainingDir,'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames' );
% Construct the bag of features for the training data
bOFeature = bagOfFeatures(imgDataStore);
% Construct the classifier
categoryClassifier = trainImageCategoryClassifier(imgDataStore, bOFeature);

% Reduced Test directory
reducedTestDir = './Assignment06_data/Assignment06_data_expanded/TestDataset';
% Construct the test data store
testImgDataStore = imageDatastore(reducedTestDir,'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames' );
% Use the classifier to get the predicted results and store it in
% confMatrix
confMatrix = evaluate(categoryClassifier, testImgDataStore);