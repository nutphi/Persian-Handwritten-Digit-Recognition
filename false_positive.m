
function [feature] = false_positive( matrix, colNo )
val = matrix;
val(logical(eye(size(val)))) = 0;
total = sum((val));
feature = total(colNo);
end