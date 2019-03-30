%% Generate binary or sinusoidal pattern 
%% with specific paramters: the min and max gray
%% value, wavlength(have to be perfect divided by the width), and image height and width

% Generate the pattern array and save the image according to specific parameters
function [pattern, figPath] = generatePattern(w, h, minGray, maxGray, wavelength, phase, isBinary)
% Check whether the image is already generated
    figName = "w" + int2str(w) + "_h" + int2str(h) + "_g" + int2str(minGray) + "_" +  int2str(maxGray) + "_wl" + int2str(wavelength) + "_p" + num2str(phase, '%0.2f\n');
    if isBinary
        figName = figName + "_B";
    else
        figName = figName + "_S";
    end
    figName = figName + ".bmp";
    current_dir = pwd();
    cd("C:\Users\’≈∑≤\Documents\Digital-Morie-3D-Reconstruction\Patterns");
    if(exist(figName))
        disp('Pattern ---- ' + figName + ' is already generated!');
        pattern = imread(char(figName)); % save for future use
        pattern = mat2gray(pattern, [0, 225]);
    else
        if isBinary
            pattern = generateBinaryPatternArray(w, h, minGray, maxGray, wavelength, phase);
        else
            pattern = generateSinPatternArray(w, h, minGray, maxGray, wavelength, phase);
        end
        imwrite(pattern, char(figName), 'BMP');
        disp('Pattern ---- ' + figName + ' is generated!');
    end
    figPath = pwd() + "/" + figName;
    cd(current_dir);
end

% Generate the sinusoidal pattern array
function pattern = generateSinPatternArray(w,h,minGray, maxGray, wavelength, phase)
    positions = linspace(0, h-1, h)';
    amplitude = (maxGray - minGray) / 2;
    standard = (maxGray + minGray) / 2;
    sinWaveMask = standard + amplitude * sin(2 * pi * positions / wavelength + phase);
    pattern = sinWaveMask * ones([1, w]); % expand as horizontal stripes
    pattern = mat2gray(pattern, [0, 255]); % grayscalize
end

% Generate the binary pattern array
function pattern = generateBinaryPatternArray(w, h, minGray, maxGray, wavelength, phase)
    positions = linspace(1 + phase, h  + phase, h)';
    amplitude = (maxGray - minGray) / 2;
    standard = (maxGray + minGray) / 2;
    squareWaveMask = standard + amplitude * squareIntergerWave(positions, wavelength);
    pattern = squareWaveMask * ones([1, w]); % expand as horizontal stripes
    pattern = mat2gray(pattern, [0, 255]); % grayscalize
end

% generate a square wave signal with respect to a single pixel
% Input:
%   positions - series of pixels positions, which is already added the
%   phase shift, starting with one
%   wavelength - period of the recurring pattern
function signal = squareIntergerWave(positions, wavelength)
    halfWavelength = floor(wavelength/2);
    signal = -1 * ones(size(positions));
    for i = 1:length(positions)
        r = mod(positions(i), wavelength);
        if r < halfWavelength
            signal(i) = 1;
        end
    end
end