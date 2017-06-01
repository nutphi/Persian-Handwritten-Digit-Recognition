
function [feature] = false_negative( matrix, rowNo )
val = matrix;
val(logical(eye(size(val)))) = 0;
total = sum((val'));
feature = total(rowNo);
end