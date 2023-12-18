function [C] = matrix_product(A, B)
[m, n] = size(A);
[n_, p] = size(B);

% check dimension mismatch
if ~(n == n_)
    error('matrix dimension mismatch error.');
end

% init empty matrix with size (m, p)
C = zeros(m, p);

for row_C = 1:m
    for col_C = 1:p
        row_A = A(row_C, :);    % get i-th row from A,
        col_B = B(:, col_C);    % get j-th dol from B

        % C(i,j) = dot_product(i-th row of A, j-th of B)
        % use element-wise product(.*) and sum(), since we can't use matrix_product
        C(row_C, col_C) = sum(row_A .* col_B');                                        
    end
end

end

