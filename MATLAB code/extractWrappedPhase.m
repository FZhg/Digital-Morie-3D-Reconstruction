%% This file contains functions that help to extract phase
%% from 4 captured deformed image; 

% Etract WrappedPhase and display the image according to paramter
% 
% Input:
%   figPath0 - the directory path of image file with zero phase shift
%   figPath1 - the directory path of image file with pi/2 phase shift
%   figPath2 - the directory path of image file with 3pi/2 phase shift
%   isDisplay - a boolean variable. When it is set true, the function
%   will display the phase map in the end. Set false, otherwise.
%
% Output:
%  wrappedPhase - the wrapped phase matrix
function wrappedPhase = extractWrappedPhase(figPath0, figPath1, figPath2)
    fig0 = inputDeformedImage(figPath0);
    fig1 = inputDeformedImage(figPath1);
    fig2 = inputDeformedImage(figPath2);
    wrappedPhase = atan((fig1 - fig2) ./ (2*fig0 - fig1 - fig2));
end

% Read and grayscalize the image file
%
% Input: 
%   figPath0 - the directory path of image file
%
% Output:
%   pattern - the grayscalized pattern matrix
function pattern = inputDeformedImage(figPath)
    figPath = char(figPath); % the url have to a characters
    pattern = imread(figPath);
    pattern = rgb2gray(pattern); % grayscale
    pattern = mat2gray(pattern, [0, 255]); % normalized
end