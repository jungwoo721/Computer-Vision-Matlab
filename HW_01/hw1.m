% part 1: Images

% 1. Read image "pittsburgh.png"
img = imread('pittsburgh.png');

% 2. Convert the image into grayscale
img_gray = rgb2gray(img);
imshow(img_gray);                       % check the result

% 3. Find the darkest pixel in the image
img_vector = img_gray(:);               % vectorize the image
[~, min_idx] = min(img_vector);         % get index of the darkest pixel (result: 967354)
[row_idx, col_idx] = ind2sub(size(img_gray), min_idx);   % linear index -> 2d index (result: [604, 1290])

% 4. Replace all pixels in the square (centered in the darkest pixel) with white pixels
for y = row_idx-15:row_idx+15
    for x = col_idx-15:col_idx+15
        img_gray(y, x) = 255;
    end
end

imshow(img_gray);                       % check the result

% 5. Place a 121x121 gray square (pixels with value 150) at the center of the image
[n_row, n_col, ~] = size(img_gray);     % get the size of the image, get the pixel in the center
center_row = floor(n_row / 2);
center_col = floor(n_col / 2);

square_top_row = center_row - floor(121/2);     % get idices of rows, cols of the box
square_bottom_row = center_row + floor(121/2);
square_left_col = center_col - floor(121/2);
square_right_col = center_col + floor(121/2);

img_gray_square = img_gray;     % copy image
img_gray_square(square_top_row:square_bottom_row, square_left_col:square_right_col) = 150;

imshow(img_gray_square);        % check the imgae

% 6. Save the modified image
imwrite(img_gray_square, 'new_image.png');

% 7. Compute the scalar average pixel value along each channel (R, G, B) separately, then subtract the average value per channel
img = imread('pittsburgh.png');
img = double(img);              % convert from uint8 to double, for mathematical operations

R_channel = img(:, :, 1);       % seperatae R, G, B channel
G_channel = img(: ,:, 2);
B_channel = img(:, :, 3);
mean_R = mean(R_channel(:));    % calculate the average pixel value
mean_G = mean(G_channel(:));
mean_B = mean(B_channel(:));

R_subtracted = R_channel - mean_R;          % subtract each channel by the average pixel value
G_subtracted = G_channel - mean_G;
B_subtracted = B_channel - mean_B;

img_empty = zeros(size(img), "double");     % create new array
img_empty(:, :, 1) = R_subtracted;          % set pixel value with each channel
img_empty(:, :, 2) = G_subtracted;
img_empty(:, :, 3) = B_subtracted;

img_subtracted = uint8(img_empty);          % convert from double to uint8
imwrite(img_subtracted, 'mean_sub.png');    % save the image
