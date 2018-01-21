%% For Getting SIFT features
% Run the Matlab SIFT feature tools
run ('./vlfeat-0.9.20/toolbox/vl_setup');

trainingDir = './Assignment06_data/Assignment06_data_reduced/TrainingDataset';
% Get the subfolders of the training dataset
trainingClasses = dir(trainingDir);
trainingClasses = trainingClasses(4 : end);

% Define the training images as a struct
trainingRes = struct;

for i = 1 : length(trainingClasses)
    % Get each class directory
    EachClass = dir(strcat(trainingDir, '/', trainingClasses(i).name, '/*.jpg'));
    % Store the f and d value for SIFT result
    ClassImgf = cell(length(EachClass), 1);
    ClassImgd = cell(length(EachClass), 1);
    
    % For each image in each of the classes
    for j = 1 : length(EachClass)
        IndivImg = imread(strcat(trainingDir, '/', trainingClasses(i).name, '/', EachClass(j).name));
        if (length(size(IndivImg)) == 3)
            IndivImg = single(rgb2gray(IndivImg));
        else
            IndivImg = single(IndivImg);
        end
        
        % Perform SIFT on all of the individual images
        disp(j);
        [f, d] = vl_sift(IndivImg);
        ClassImgf(j) = {f};
        ClassImgd(j) = {d};
    end
    
    % Store all of the data from each class to the overall training results
    trainingRes.f.(matlab.lang.makeValidName(trainingClasses(i).name)) = ClassImgf;
    trainingRes.d.(matlab.lang.makeValidName(trainingClasses(i).name)) = ClassImgd;
end