reducedDir = './Assignment06_data/Assignment06_data_reduced/TestDataset_';
reducedRes = zeros(length(histForAll));

for i = 1 : length(histForAll)
    % Directory of each individual test data set
    indivReducedDir = dir(strcat(reducedDir, num2str(i)));
    indivReducedDir = indivReducedDir(3 : end);
    for j = 1 : length(indivReducedDir)
        % Each image in each subfolder
        img = rgb2gray(imread(strcat(reducedDir, num2str(i), '/', indivReducedDir(j).name)));
        % Get the SIFT features of each image
        [f, d] = vl_sift(single(img));
        % Use knnsearch to find each feature points in their corresponding cluster
        [Idx, D] = knnsearch(cell2mat(cluster(1, :))', single(d)', 'Distance', 'cityblock');
        threshold = median(D) * 1.5;
        Idx(D > threshold) = [];
        histForEach = zeros(1, N);

        % Count the number of each Index in the tested image
        for k = 1 : length(Idx)
            histForEach(Idx(k)) = histForEach(Idx(k)) + 1;
        end

        % Normalize the histForEach to get the percentage
        histForEach = histForEach./length(Idx);
        % Use knnsearch to find the predicted results of each image about which class it belongs to
        predictedRes = knnsearch(cell2mat(vertcat(histForAll)), histForEach);
        % Get results for the reduced data set
        reducedRes(i, predictedRes) = reducedRes(i, predictedRes) + 1;
    end
end

% Get the percentage of each prediction accuracy
reducedRes = reducedRes./repmat(sum(reducedRes, 2), 1, length(histForAll));