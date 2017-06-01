function [feature] = feature_extraction( image )

calculate_eachblock = @(block_struct) sum(sum(block_struct.data));
[row,col]=size(image);
features_matrix = blockproc(image,[3 3],calculate_eachblock);
feature=reshape(features_matrix',1,(row/3)*(col/3));
end