function padded = pad_matrix(matrix, pad_value)
% pads a matrix with pad_value
[height, width] = size(matrix);
appendrow = ones(1, width + 2) .* pad_value;
appendcol = ones(height, 1) .* pad_value;
padded = [appendrow;
          appendcol, matrix, appendcol;...
          appendrow];
end