% Code written for CSI 4116 by Seong Jae Hwang
% Do not distribute
function reducedColorImage = reduceHeight(im, display_flag)
% If the display_flag is not specified in the input, the default is False.
if nargin < 2
    display_flag = false;
end
[num_rows, num_cols, num_channels] = size(im);

% Compute the energy image and cumulative energy map
Ix_kernel = [1 0 -1; 2 0 -2; 1 0 -1];
Iy_kernel = [1 0 -1; 2 0 -2; 1 0 -1]';
energyImage = energy_image(im, Ix_kernel, Iy_kernel);
M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');

% Identify the seam
horiz_seam = find_optimal_horizontal_seam(M);
assert(length(horiz_seam) == num_cols);

% Initialize an empty image of the reduced size
reducedColorImage = zeros([num_rows-1 num_cols num_channels]);

for i = 1:num_cols
    for j = 1:num_channels
        % For each column i at channel j
        this_col = im(:, i, j);
        % Remove the pixel correponding to the seam
        this_col(horiz_seam(i)) = [];
        % Assign the reduced column to the reduced image at column i,
        % channel j
        reducedColorImage(:, i, j) = this_col;
    end      
end

% Typecast the image to be of uint8
reducedColorImage = uint8(reducedColorImage);

% If display_flag == 1, plot the energy image, cumulative energy map, and
% the original image with the seam for visualization
if display_flag 
    figure;
    subplot(1, 3, 1); imagesc(energyImage); axis image; title('Energy Map');
    subplot(1, 3, 2); imagesc(M); axis image; title('M')
    subplot(1, 3, 3); imshow(im); displaySeam(im, horiz_seam, 'HORIZONTAL');
    axis image; title('Seam');
end