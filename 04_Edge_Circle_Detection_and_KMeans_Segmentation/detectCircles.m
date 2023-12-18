function [centers] = detectCircles(im, edges, radius, top_k)
quantization_value = 5;             % set quantization value

[num_row, num_col, ~] = size(im);   % size of image
[num_edges, ~] = size(edges);       % number of edges

H = zeros(num_row, num_col);        % init matrix H, centers to 0s.
centers = zeros(top_k, 2);

for edge = 1:num_edges
    x = edges(edge, 1);             % get x, y, degree
    y = edges(edge, 2);
    theta = edges(edge, 4);
    
    a = x - (radius * cosd(theta));   % calculate coords (before quantization)
    b = y - (radius * sind(theta));

    if (a >= 1) && (a <= num_col) && (b >= 1) && (b <= num_row) % += 1 only if center coord. in the range of the image
        a_bin_idx = abs(ceil(a / quantization_value)) + 1;     % quantize, pos. int. (get indices for bins)
        b_bin_idx = abs(ceil(b / quantization_value)) + 1; 
        H(a_bin_idx, b_bin_idx) = H(a_bin_idx, b_bin_idx) + 1;
    end
end

vectorized_H = H(:);    % vectorize (to sort)
[~, idx] = sort(vectorized_H, 'descend');      % sort, descending order

top_k_ids = idx(1:top_k);                      % get top_k indices
[x_H, y_H] = ind2sub(size(H), top_k_ids);      % x, y idx (of H) with top_k values

for i = 1:top_k
    center_x = x_H(i) * quantization_value - ceil(0.5 * quantization_value);    % restore coords (-1/2 * quantize_value) to make more precise (choose center pixel in the bin)
    center_y = y_H(i) * quantization_value - ceil(0.5 * quantization_value);    % to make more precise (choose center pixel in the bin). ex) a = 8.xx -> a_bin_idx = 2 -> restored_x = 2*5 -2 = 8
    centers(i, 1) = center_x;                                                   % store top_k center pos. if valid
    centers(i, 2) = center_y;                                                   % store top_k center pos. if valid
end

% visualize circles
figure; 
imshow(im); 
viscircles(centers, radius * ones(size(centers, 1), 1));
end

