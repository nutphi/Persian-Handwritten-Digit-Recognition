function AI_Project_Clustering( featureNo, distanceMetricNo )

imageDir = fullfile('G:\', 'My Documents','MATLAB','data', 'Clustering_100', '0');

imageSet = imageDatastore(imageDir,   'IncludeSubfolders', true, 'LabelSource', 'foldernames');


numImages = numel(imageSet.Files);


switch featureNo
    case 1
        row = 21;
        col = 21;
        imageFeatures = zeros(numImages, (row/3)*(col/3), 'single');
        for i = 1:numImages
            img = readimage(imageSet, i);
            img = imresize(img, [row col]);
            imageFeatures(i, :) = feature_extraction(img);  
        end
    case 2
        imageFeatures = zeros(numImages, 21*21, 'single');
        for i = 1:numImages
            
            img = readimage(imageSet, i);
            img = imresize(img, [21 21]);
            imageFeatures(i, :) = row_extraction(img);
        end
    case 3
        row = 12;
        col = 12;
        imageFeatures = zeros(numImages, (row/3)*(col/3), 'single');
        for i = 1:numImages
            img = readimage(imageSet, i);
            img = imresize(img, [row col]);
            imageFeatures(i, :) = feature_extraction(img);  
        end
    otherwise
        error('Please choose value between 1 and 3 to run the feature extraction method')
end

switch distanceMetricNo
    case 1
        centroid = distanceMetricFunction(imageFeatures, 'cityblock');
        [n,d]=knnsearch(imageFeatures, centroid, 'k', 1, 'distance', 'cityblock');
        disp(n)
        for i = 1:length(n)
            test = readimage(imageSet, n(i));
            imtool(test);
        end
    case 2
        centroid = distanceMetricFunction(imageFeatures, 'cosine');
        [n,d]=knnsearch(imageFeatures, centroid, 'k', 1, 'distance', 'cosine');
        disp(n)
        for i = 1:length(n)
            test = readimage(imageSet, n(i));
            imtool(test);
        end
    case 3
        centroid = distanceMetricFunction(imageFeatures, 'sqeuclidean');
        [n,d]=knnsearch(imageFeatures, centroid, 'k', 1, 'distance', 'euclidean');
        disp(n)
        for i = 1:length(n)
            test = readimage(imageSet, n(i));
            imtool(test);
        end
    otherwise
        error('Please choose value between 1 and 3 to run the distance metric method')
end

end