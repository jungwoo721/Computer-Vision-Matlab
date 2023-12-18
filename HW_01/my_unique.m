function [N] = my_unique(M)

[num_row, ~] = size(M);
% init first row of N with first row of M
N = M(1, :);
for row = 2:num_row
    unique = 1;     % set unique to 1. remains at 1 if no other same row exists
    for row_below = 1:row-1
        if isequal(M(row, :), M(row_below, :))    % if the same row exists, set unique to 0
            unique = 0;
            break
        end
    end

    % if the row is unique, concat to N along row axis
    if unique == 1
        N = cat(1, N, M(row, :));
    else
        continue
    end
end

end

