function [feature] = true_positive( matrix, label )
feature = matrix(label,label);
end