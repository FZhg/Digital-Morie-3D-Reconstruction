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
function [fig0, fig1, fig2, fig3] = digitalMorieSuperimpose(figPath, patternPath, deltaPixel, isDispaly)
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
    phase0 = phase;
    phase1 = phase + wavelength / 2;
    phase2 = phase + deltaPixel;
    phase3 = phase +  wavelength / 2 + deltaPixel;
    
    [pattern0, ~] = generatePattern(width, height, minGray, maxGray, wavelength, phase0, isBinary);
    [pattern1, ~] = generatePattern(width, height, minGray, maxGray, wavelength, phase1, isBinary);
    [pattern2, ~] = generatePattern(width, height, minGray, maxGray, wavelength, phase2, isBinary);
    [pattern3, ~] = generatePattern(width, height, minGray, maxGray, wavelength, phase3, isBinary);
    
    figCaptured = inputDeformedImage(figPath);
    
    % save generated figures
    [fig0, figPath0] = superimposeSingle(pattern0, figCaptured ,figPath, phase0);
    [fig1, figPath1] = superimposeSingle(pattern1, figCaptured ,figPath, phase1);
    [fig2, figPath2] = superimposeSingle(pattern2, figCaptured, figPath, phase2);
    [fig3, figPath3] = superimposeSingle(pattern3, figCaptured ,figPath, phase3);
    
    % display the generated figures path
    disp("Figure on " + figPath0 + " is generated.");
    disp("Figure on " + figPath1 + " is generated.");
    disp("Figure on " + figPath2 + " is generated.");
    disp("Figure on " + figPath3 + " is generated.");
    
    
    % display the image
    if isDispaly
        figure1=figure('Position', [100, 100, 2048, 1536]);
        colormap('gray');
        
        subplot(2, 2, 1);
        imagesc(fig0, [0, 1]);
        title("Zero Phase-shift");
        
        subplot(2, 2, 2)
        imagesc(fig1, [0, 1]);
        title("\pi Phase-shift ");
        
        subplot(2, 2, 3)
        imagesc(fig2, [0, 1]);
        title("\delta Phase-shift ");
        
        subplot(2, 2, 4)
        imagesc(fig3, [0, 1]);
        title("\delta + \pi Phase-shift")
        
    end
end

% Superimpose the phase-shifted pattern and captured image
% Input:
%   pattern - the phase-shifted the pattern matrix
%   figCaptured - the captured frame matrix, which is already grayscalized
%   figPath - the directory path of captured image
%   phase - the phase value from the pattern matrix
% Output:
%   newFig - the phase-shifted image matrix
%   newFigPath - the phase-shifted image directory path 
function [newFig, newFigPath] = superimposeSingle(pattern, figCaptured, figPath, phase)
    figPath = char(figPath);
    newFigPath = figPath(1:end-6) + "p" + num2str(phase) + ".bmp";
    newFig = figCaptured .* pattern;
    imwrite(newFig, char(newFigPath));
end