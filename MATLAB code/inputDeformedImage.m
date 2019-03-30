% Read and grayscalize the image file
%
% Input: 
%   figPath0 - the directory path of image file
%  
% Output:
%   fig - the grayscalized pattern matrix
function fig = inputDeformedImage(figPath)
    figPath = char(figPath); % the url have to a characters
    fig = imread(figPath);
    figSize = size(fig);
    if figSize(end) == 3
        fig = rgb2gray(fig); % grayscale
    end
    fig = mat2gray(fig, [0, 255]); % normalized
end