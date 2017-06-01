function [total] = true_negative( matrix, label )
val = matrix;
val(label, :) = [];
val(:, label) = [];
total = sum(sum((val)));
end