%% This file contains function that calculates Rough Index for all four deformed images


% Calculate the Rough Index for one image by convolving the image with
% Sobel vertical edge detector filter
% Input:
%   fig - the fig matrix
% Output:
%   roughIndex - the rough Index of the image

function roughnessIndex = getRoughnessIndex(fig)
    h = [-1 -2 -1; 0 0 0; +1 +2 +1];
    verticalEdge = conv2(h, fig);
    roughnessIndex = norm(verticalEdge, 1) / norm(fig, 1);
end