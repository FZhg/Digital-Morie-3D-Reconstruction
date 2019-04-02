%% This file display the image under a gray colormap
%% Input:
%%  figMatrix - the Matrix that  represent the grayscalized image
%%  titleString - the fig title
function displayFig(figMatrix, titleString)
    figure
    colormap('gray');
    imagesc(figMatrix);
    title(titleString);
end