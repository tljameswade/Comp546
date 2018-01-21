%% For creating histograms
% Histogram for all classes
histForAll = cell(length(trainingClasses), 1);

for i = 1: length(trainingClasses)
    % Histogram for each class
    histForEach = zeros(1, N);
    k = matlab.lang.makeValidName(trainingClasses(i).name);
    
    % Features combined in each class
    IndivClassFeature1 = single(cell2mat(horzcat(trainingRes.d.(k)')));
    
    % Search for nearest neighbors
    [Idx, D] = knnsearch(cluster{1, 1}', IndivClassFeature1', 'Distance', 'cityblock');
    
    % Set the threshold
    threshold = median(D) * 1.5;
    Idx(D > threshold) = [];
    
    % Set the histogram for each Index by counting
    for j = 1 : length(Idx)
        histForEach(Idx(j)) = histForEach(Idx(j)) + 1;
    end
    
    % Normalize each histogram by dividing by the length of Index vector
    histForEach = histForEach./length(Idx);
    histForAll(i) = {histForEach};
    
    % Plot the histogram for each training class into one graph
    figure(i)
    plot(histForEach);
    title(trainingClasses(i).name);    
end