%% After capturing a single frame of image, shift the pattern by a phase of pi, delta, and delta + pi
%% ; Then superimpose the two phase-shifted pattern with the captured image

% Generate virtually two phase-shifted images and display them
% Input:
%   figPath - the directory path of the captured image
%   patternPath - the directory path of used pattern
%   deltaPixel - the smallest pixel moved
%   isDisplay - logic true
% Output£º
%   figZeroPS - the dfig of grayscalized caputured image
%   figPiPS - the fig of grayscalized image with the phase
%   shift of pi
%   figDeltaPS - the fig of grayscalized image with the phase delta;
%   figDeltaPiPS - the fig of grayscalized image with the phase delta + pi
function [figZeroPS, figPiPS, figDeltaPS, figDeltaPiPS] = digitalMorieSuperimpose(figPath, patternPath, deltaPixel, isDispaly)
    currentPath = pwd();
    cd("..\Patterns");
    directoryPath = pwd();
    patternPath = char(patternPath);
    patternName = patternPath(length(directoryPath)+1:end); % add the / simbol
    cd(currentPath);
    
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
    pitch = str2num(patternName(startIndex+2:endIndex-1)); %#ok<*ST2NM>
    
    % take out the phase
    [startIndex, endIndex] = regexp(patternName, 'p[\d]*.[\d]*_');
    phase = str2num(patternName(startIndex+1:endIndex-1));
    
    % take out the binary or sinuidal signal
    isBinary = (patternName(end-4) == 'B');
    
    % new phases
    phaseZero = phase;
    phasePi = phase + pitch / 2;
    phaseDelta = phase + deltaPixel;
    phaseDeltaPi = phase +  pitch / 2 + deltaPixel;
    
    [pattern0, ~] = generatePattern(width, height, minGray, maxGray, pitch, phaseZero, isBinary);
    [pattern1, ~] = generatePattern(width, height, minGray, maxGray, pitch, phasePi, isBinary);
    [pattern2, ~] = generatePattern(width, height, minGray, maxGray, pitch, phaseDelta, isBinary);
    [pattern3, ~] = generatePattern(width, height, minGray, maxGray, pitch, phaseDeltaPi, isBinary);
    
    figCaptured = inputDeformedImage(figPath);
    
    % save generated figures
    [figZeroPS, figPath0] = superimposeSingle(pattern0, figCaptured ,figPath, phaseZero);
    [figPiPS, figPath1] = superimposeSingle(pattern1, figCaptured ,figPath, phasePi);
    [figDeltaPS, figPath2] = superimposeSingle(pattern2, figCaptured, figPath, phaseDelta);
    [figDeltaPiPS, figPath3] = superimposeSingle(pattern3, figCaptured ,figPath, phaseDeltaPi);
    
    % display the generated figures path
    disp("Figure on " + figPath0 + " is generated.");
    disp("Figure on " + figPath1 + " is generated.");
    disp("Figure on " + figPath2 + " is generated.");
    disp("Figure on " + figPath3 + " is generated.");
    
    
    % display the image
    if isDispaly
        figure('Position', [100, 100, 2048, 1536]);
        colormap('gray');
        
        subplot(2, 2, 1);
        imagesc(figZeroPS, [0, 1]);
        title("Zero Phase-shift");
        
        subplot(2, 2, 2)
        imagesc(figPiPS, [0, 1]);
        title("\pi Phase-shift ");
        
        subplot(2, 2, 3)
        imagesc(figDeltaPS, [0, 1]);
        title("\delta Phase-shift ");
        
        subplot(2, 2, 4)
        imagesc(figDeltaPiPS, [0, 1]);
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