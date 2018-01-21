%% For clustering
% Number of clusters
N = 1000;

% Clustered features
cluster = cell(2,1); 

% The field of the first training class of the training results
k = matlab.lang.makeValidName(trainingClasses(1).name);
 
% concatenate all features within one class
IndivClassFeature = cell2mat(horzcat(trainingRes.d.(k)'));

for i = 2: length(trainingClasses)
    k = matlab.lang.makeValidName(trainingClasses(i).name);
    IndivClassFeature = [IndivClassFeature cell2mat(horzcat(trainingRes.d.(k)'))];
end

% clustering all training imgs using vl_kmeans
[C, A] = vl_kmeans(single(IndivClassFeature), N, 'distance', 'l1');
cluster(:, 1) = {C, A};
