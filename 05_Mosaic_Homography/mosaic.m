%% A: load images
img1 = imread('uttower1.jpeg');
img2 = imread('uttower2.jpeg');

%% B: select matching points (given)
% uttower1
PA = [481, 310; 328, 510; 106, 507; 108, 619; 56, 176; 129, 483; 526, 537; 375, 293];
% uttower2
PB = [928, 331; 782, 540; 569, 545; 578, 652; 505, 232; 585, 519; 998, 567; 816, 322];

% keble1
%PA = [165, 78; ...
%      154, 186; ...
%      327, 106; ...
%      354, 170; ...
%      340, 14; ...
%      271, 43];
% keble2
%PB = [68, 88; ...
%      55, 198; ...
%      229, 123; ...
%      252, 186; ...
%      243, 34; ...
%      177, 57];
%% C: compute homography
H = estimate_homography(PA, PB);

%% D: check if it works well (given by homography_examples.m)
% transform all PA to PA_transformed using the estimated homography
PA_transformed = [];
for i=1:size(PA, 1)
    p1 = PA(i,:);
    p2 = apply_homography(p1, H);
    PA_transformed = [PA_transformed; p2];
end

% check another point..
%p1 = [300, 640];
%[p2] = apply_homography(p1, H);
%PA = [PA; p1];
%PA_transformed = [PA_transformed; p2];

% If our homography H is accurate, then PA_transformed should be similar to
% PB which are the true correspondences. Check this yourself by outputting
% the values or by plotting below.
%img1 = 'uttower1.jpeg'; img2 = 'uttower2.jpeg';   % set img1, img2 to apply homography

figure;
subplot(1,2,1); hold on; 
imshow(img1); plot(PA(:,1), PA(:,2), 'g.', 'MarkerSize', 20);
title('PA shown in Image 1');
subplot(1,2,2); hold on; 
imshow(img2); plot(PA_transformed(:,1), PA_transformed(:,2), 'r.', 'MarkerSize', 20);
title('PA transformed and shown in Image 2');

%% E: stitch a mosaic
% create a new canvas to stitch two images (code provided)
nr = size(img2, 1);
nc = size(img2, 2);
canvas = uint8(zeros(3*nr, 3*nc, 3));
canvas(nr:2*nr-1, nc:2*nc-1, :) = img2;

% stitch
for row = 1:nr
    for col = 1:nc
        pixel = [col, row];
	
	    % apply homography
        transformed_pixel = apply_homography(pixel, H);
        x = transformed_pixel(1);
        y = transformed_pixel(2);
	
	    % location on the canvas (coordinate translation)
        loc_top_left = [nc+floor(x), nr+floor(y)];
        loc_top_right = [nc+floor(x), nr+ceil(y)];
        loc_bottom_left = [nc+ceil(x), nr+floor(y)];
        loc_bottom_right = [nc+ceil(x), nr+ceil(y)];
        
        % paste the pixel (4 nearby pixels)
        canvas(loc_top_left(2) ,loc_top_left(1), :) = img1(row, col, :);
        canvas(loc_top_right(2),loc_top_right(1), :) = img1(row, col, :);
        canvas(loc_bottom_left(2),loc_bottom_left(1), :) = img1(row, col, :);
        canvas(loc_bottom_right(2),loc_bottom_right(1), :) = img1(row, col, :);
    end
end

% save the stitched result 
imwrite(canvas, 'uttower_mosaic.png')
