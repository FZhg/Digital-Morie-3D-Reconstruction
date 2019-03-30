%% After capturing a single frame of image, shift the pattern by a phase of pi/2
%% or -pi/2; Then superimpose the two phase-shifted pattern with the captured image

% Generate virtually two phase-shifted images and display them
% Input:
%   figPath - the directory path of the captured image
%   patternPath - the directory path of used pattern
% Output£º
%   figPath0 - the directory path of grayscalized caputured image
%   figPath1 - the directory path of grayscalized image with the phase
%   shift of pi / 2;
%   figPath2 - the directory path of grayscalized image with the phase
%   shift of 3 pi / 2 or - pi / 2;
function [figPath0, figPath1, figPath2] = digitalMorieSuperimpose(figPath, patternPath, isDispaly)
    patternPath = char(patternPath);
    patternName = patternPath(end-32:end); 
    
    % take out the width
    [startIndex, endIndex] = regexp(patternName, 'w[\d]*_');
    width = str2num(patternName(startIndex+1:endIndex-1));
    
    % take out the height
    [startIndex, endIndex] = regexp(patternName, 'h[\d]*_');
    height = str2num(patternName(startIndex+1:endIndex-1));
    
    % take out the minimum gray value
    [startIndex, endIndex] = regexp(patternName, 'g[\d]*_');
    minGray = str2num(patternName(startIndex+1:endIndex-1));
    
    % take out the maxium gray value
    [startIndex, endIndex] = regexp(patternName, '_[\d]*_');
    maxGray = str2num(patternName(startIndex+1:endIndex-1));
    
    % take out the wavelength
    [startIndex, endIndex] = regexp(patternName, 'wl[\d]*_');
    wavelength = str2num(patternName(startIndex+2:endIndex-1));
    
    % take out the phase
    [startIndex, endIndex] = regexp(patternName, 'p[\d]*.[\d]*_');
    phase = str2num(patternName(startIndex+1:endIndex-1));
    
    % take out the binary or sinuidal signal
    isBinary = (patternName(end-4) == 'B');
    
    % nwe phases
    phase1 = phase+pi/2;
    phase2 = phase + 3 * pi /2; 
    
    [pattern1, ~] = generatePattern(width, height, minGray, maxGray, wavelength, phase1, isBinary);
    [pattern2, ~] = generatePattern(width, height, minGray, maxGray, wavelength, phase2, isBinary);
    
    % save the fig0
    fig0 = inputDeformedImage(figPath);
    figPath = char(figPath);
    figPath0 = figPath(1:end-6) + "p" + num2str(phase) + ".bmp";
    imwrite(fig0, char(figPath0), 'WriteMode', 'overwrite');
    
    % save fig1 and fig2
    [fig1, figPath1] = superimposeSingle(pattern1, figPath, phase1);
    [fig2, figPath2] = superimposeSingle(pattern2, figPath, phase2);
    
    % display the image
    if isDispaly
        figure1=figure('Position', [100, 100, 320, 720]);
        colormap('gray');
        
        subplot(3, 1, 1);
        imagesc(fig0, [0, 1]);
        title("Phase " + num2str(phase));
        
        subplot(3, 1, 2)
        imagesc(fig1, [0, 1]);
        title("Phase " + num2str(phase1));
        
        subplot(3, 1, 3)
        imagesc(fig2, [0, 1]);
        title("Phase " + num2str(phase2));
        
    end
end

% Superimpose the phase-shifted pattern and captured image
% Input:
%   pattern - the phase-shifted the pattern matrix
%   figPath - the directory path of captured image
%   phase - the phase value from the pattern matrix
% Output:
%   newFig - the phase-shifted image matrix
%   newFigPath - the phase-shifted image directory path 
function [newFig, newFigPath] = superimposeSingle(pattern, figPath, phase)
    fig = inputDeformedImage(figPath);
    figPath = char(figPath);
    newFigPath = figPath(1:end-6) + "p" + num2str(phase) + ".bmp";
    newFig = fig .* pattern;
    imwrite(newFig, char(newFigPath), 'WriteMode', 'overwrite');
end