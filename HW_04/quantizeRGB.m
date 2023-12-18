function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg,k)
[numrows, numcolumns, numchannels] = size(origImg);
numpixels = numrows * numcolumns;

origImg_double = double(origImg);
resized_img = reshape(origImg_double, [numpixels, numchannels]);

outputImg_double = origImg_double;

[clusterIds, meanColors] = kmeans(resized_img, k);          % clusterIds: [row*col, 1(clusterID)]
resized_idx = reshape(clusterIds, [numrows, numcolumns]);   % resized_idx (index matrix): [row, col, 1(clusterID)]

for row = 1:numrows                        % assign meanColors to each pixels
    for col = 1:numcolumns
        cluster = resized_idx(row, col);
        outputImg_double(row, col, :) = meanColors(cluster, :);
    end
end

outputImg = uint8(outputImg_double); % or, outputImg = outputImg_double / 255;

end

