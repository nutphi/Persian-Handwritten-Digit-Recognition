function [result] = distanceMetricFunction( imageFeatures, distanceMetricFunName )
    
    [clustering1,center1] =kmeans(imageFeatures ,3,'Distance',distanceMetricFunName);
    [silh1,h1] = silhouette(imageFeatures,clustering1,distanceMetricFunName);
    cluster1 = mean(silh1);
    
    [clustering2,center2] =kmeans(imageFeatures ,4,'Distance',distanceMetricFunName);
    [silh2,h2] = silhouette(imageFeatures,clustering2,distanceMetricFunName);
    cluster2 = mean(silh2);
    
    [clustering3,center3] =kmeans(imageFeatures ,5,'Distance',distanceMetricFunName);
    [silh3,h3] = silhouette(imageFeatures,clustering3,distanceMetricFunName);
    cluster3 = mean(silh3);
    
    if(cluster1 > cluster2 && cluster1 > cluster3)
        result = center1;
    elseif(cluster2 > cluster1 && cluster2 > cluster3)
        result = center2;
    else
        result = center3;
    end
end