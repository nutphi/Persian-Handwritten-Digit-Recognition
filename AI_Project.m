function AI_Project( featureNo , classifierNo )

trainingDir = fullfile('G:\', 'My Documents','MATLAB','data', 'Training_60');

testDir = fullfile('G:\', 'My Documents','MATLAB','data', 'Testing_20');


trainingSet = imageDatastore(trainingDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

testSet = imageDatastore(testDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');


countEachLabel(trainingSet)

countEachLabel(testSet)


numImages = numel(trainingSet.Files);




switch featureNo
    case 1
        row = 21;
        col = 21;
        trainingFeatures = zeros(numImages, (row/3)*(col/3), 'single');
        for i = 1:numImages
            img = readimage(trainingSet, i);
            img = imresize(img, [row col]);
            trainingFeatures(i, :) = feature_extraction(img);  
        end
    case 2
        trainingFeatures = zeros(numImages, 21*21, 'single');
        for i = 1:numImages
            
            img = readimage(trainingSet, i);
            img = imresize(img, [21 21]);
            trainingFeatures(i, :) = row_extraction(img);
        end
    case 3
        row = 12;
        col = 12;
        trainingFeatures = zeros(numImages, (row/3)*(col/3), 'single');
        for i = 1:numImages
            img = readimage(trainingSet, i);
            img = imresize(img, [row col]);
            trainingFeatures(i, :) = feature_extraction(img);  
        end
    otherwise
        error('Please choose value between 1 and 3 to run the feature extraction method')
end

% Get labels for each image.

trainingLabels = trainingSet.Labels;

switch classifierNo
    case 1
        classifier = fitctree(trainingFeatures, trainingLabels);
    case 2
        classifier = fitcecoc(trainingFeatures, trainingLabels);
    case 3
        classifier = fitcknn(trainingFeatures, trainingLabels);
    case 4
        classifier = fitcnb(trainingFeatures, trainingLabels, 'Distribution', 'mn');
        %Assuming that there is no bug anywhere in your code (or NaiveBayes code from mathworks), and again assuming that your training_data is in the form of NxD where there are N observations and D features, then columns 2, 5, and 6 are completely zero for at least a single class. This can happen if you have relatively small training data and high number of classes, in which a single class may be represented by a few observations. Since NaiveBayes by default treats all features as part of a normal distribution, it cannot work with a column that has zero variance for all features related to a single class. In other words, there is no way for NaiveBayes to find the parameters of the probability distribution by fitting a normal distribution to the features of that specific class (note: the default for distribution is normal).
        %Take a look at the nature of your features. If they seem to not follow a normal distribution within each class, then normal is not the option you want to use. Maybe your data is closer to a multinomial model mn:
    otherwise
        error('Please choose value between 1 and 4 to run the classifier')
end

numImages = numel(testSet.Files);



switch featureNo
    case 1
        row = 21;
        col = 21;
        testFeatures = zeros(numImages, (row/3)*(col/3), 'single');
        for i = 1:numImages

            img = readimage(testSet, i);
            img = imresize(img, [row col]);
            testFeatures(i, :) = feature_extraction(img);  

        end
    case 2
        testFeatures = zeros(numImages, 21*21, 'single');
        for i = 1:numImages    
            img = readimage(testSet, i);
            img = imresize(img, [21 21]);

            testFeatures(i, :) = row_extraction(img);  

        end
    case 3
        row = 12;
        col = 12;
        testFeatures = zeros(numImages, (row/3)*(col/3), 'single');
        for i = 1:numImages
            img = readimage(testSet, i);
            img = imresize(img, [row col]);
            testFeatures(i, :) = feature_extraction(img);  
        end
    otherwise
        error('Please choose value between 1 and 3 to run the feature extraction method')
end

% Get labels for each image.

testLabels = testSet.Labels;


% Make class predictions using the test features.

predictedLabels = predict(classifier, testFeatures);


% Tabulate the results using a confusion matrix.

confMat = confusionmat(testLabels, predictedLabels);

helperDisplayConfusionMatrix(confMat);

% Calculating accuracy for confusion matrix
disp('Accuracy for clasifier:')
accuracy = all_accuracy(confMat);
disp(accuracy)

trueNegativeRate = zeros(10, 1);
truePositiveRate = zeros(10, 1);

% Calculating true negative rate and true positive rate for each class
for i = 1:10

    disp('true negative rate for: ')
    disp(i-1)
    
    trueNegativeRate(i, 1) = true_negative_rate(confMat, i);
    
    disp(trueNegativeRate(i, 1))
    
    disp('true positive rate for: ')
    disp(i-1)
    
    truePositiveRate(i, 1) = true_positive_rate(confMat, i);
    
    disp(truePositiveRate(i, 1))

end

end