function displaySeam(im, seam, seamDirection)

[nr, nc, ~] = size(im);
hold on;
if strcmp(seamDirection, 'VERTICAL')
    plot(seam, 1:nr, 'r.');  % this also works.
elseif strcmp(seamDirection, 'HORIZONTAL')
    plot(1:length(seam), seam, 'r.')  % this also works.
end
% axis ij;