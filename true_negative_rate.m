function [total] = true_negative_rate( matrix, label )
tn = true_negative(matrix,label);
fp = false_positive(matrix,label);
total = tn/(tn+fp);
end