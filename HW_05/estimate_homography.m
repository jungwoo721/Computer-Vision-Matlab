function H = estimate_homography(PA, PB)
num_points = size(PA, 1);   % number of pairs

A = [];   % init matrix A
for point = 1:num_points
    % read points
    x = PA(point, 1);    
    y = PA(point, 2);
    x_prime = PB(point, 1); 
    y_prime = PB(point, 2);     
    
    % reshape
    A_per_pair = [-x, -y, -1, 0, 0, 0, x * x_prime, y * x_prime, x_prime;
                  0, 0, 0, -x, -y, -1, x * y_prime, y * y_prime, y_prime];      
    
    % concat, axis=1
    A = [A; A_per_pair];
end

% solve for H
[~, ~, V] = svd(A); 
h = V(:, end); 
H = reshape(h, 3, 3)';

end