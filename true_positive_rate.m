%same as helperDisplayConfusionMatrix
function [total] = true_positive_rate( matrix, label )
tp = true_positive(matrix,label);
fn = false_negative(matrix,label);
total = tp/(tp+fn);
end