%% Problem 1 and Problem 3c: Test estimate_homography for keble images
% Use these correspondences for HW5.
% keble1
PA = [165, 78; ...
      154, 186; ...
      327, 106; ...
      354, 170; ...
      340, 14; ...
      271, 43];
% keble2
PB = [68, 88; ...
      55, 198; ...
      229, 123; ...
      252, 186; ...
      243, 34; ...
      177, 57];

H = estimate_homography(PA, PB);
% 
% H =
% 
%     0.0098   -0.0001   -0.9968
%     0.0008    0.0095   -0.0788
%     0.0000    0.0000    0.0085

%% Problem 3d: Test apply_homography
% transform all PA to PA_transformed using the estimated homography
PA_transformed = [];
for i=1:size(PA, 1)
    p1 = PA(i,:);
    p2 = apply_homography(p1, H);
    PA_transformed = [PA_transformed; p2];
end

% If our homography H is accurate, then PA_transformed should be similar to
% PB which are the true correspondences. Check this yourself by outputting
% the values or by plotting below.
img1 = 'uttower1.jpeg'; img2 = 'uttower2.jpeg';   % set img1, img2 to apply homography

figure;
subplot(1,2,1); hold on; 
imshow(img1); plot(PA(:,1), PA(:,2), 'g.', 'MarkerSize', 20);
title('PA shown in Image 1');
subplot(1,2,2); hold on; 
imshow(img2); plot(PA_transformed(:,1), PA_transformed(:,2), 'r.', 'MarkerSize', 20);
title('PA transformed and shown in Image 2');

%% Problem 4: Correspondences for uttower images
% uttower1
% PA = [481, 310; 328, 510; 106, 507; 108, 619; 56, 176; 129, 483; 526, 537; 375, 293];
% % uttower2
% PB = [928, 331; 782, 540; 569, 545; 578, 652; 505, 232; 585, 519; 998, 567; 816, 322];
