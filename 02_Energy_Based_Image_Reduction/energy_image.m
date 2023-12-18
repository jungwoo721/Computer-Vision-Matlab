function [energyImage, Ix, Iy] = energy_image(im, Ix_kernel, Iy_kernel)
% rgb -> gray, dtype to double
im_gray = rgb2gray(im);
im_gray_double = double(im_gray);

% apply Ix_kernel, Iy_kernel to the image respectively
Ix = imfilter(im_gray_double, Ix_kernel);
Iy = imfilter(im_gray_double, Iy_kernel);

% get the energyImage by applying L2 Norm
energyImage = sqrt(Ix .^ 2 + Iy .^ 2);

end
