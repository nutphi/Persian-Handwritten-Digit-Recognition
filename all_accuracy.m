function [accuracy] = all_accuracy( matrix)
accuracy = sum(diag(matrix))/sum(sum(matrix));
end
