%% This file contains function that removes the Grid for four different images
%% with SWTFFT method

%Remove the grid noises according to SWTFFT method
% Input:
%   figZeroPS - the fig matrix with zero phase shift
%   figPiPS - the fig matrix with pi phase shift
%   figDeltaPS - the fig matrix with delta phase shift
%   figDeltaPiPS - the fig matrix with delta  + pi phase shift
%   decNum - the optimized decompostion level, an interger
%   wName - the wavlet function that performs the best
%   sigma - the optimized the damping factor
%   isDisplay - the boolean variable; when it is true, the result will be
%   shown
%
%
% Output:
%   figZeroPSFiltered - the filtered fig matrix with zero phase shift
%   figPiPSFiltered - the filtered fig matrix with pi phase shift
%   figDeltaPSFiltered - the filtered fig matrix with delta phase shift
%   figDeltaPiPSFiltered - the filtered fig matrix with delta  + pi phase shift   
function [figZeroPSFiltered, figPiPSFiltered, figDeltaPSFiltered, figDeltaPiPSFiltered] = removeGridSWTFFT(figZeroPS, figPiPS, figDeltaPS, figDeltaPiPS, decNum, wName, sigma, isDisplay)
    figZeroPSFiltered = SWTFFT(figZeroPS, decNum, wName, sigma);
    figPiPSFiltered = SWTFFT(figPiPS, decNum, wName, sigma);
    figDeltaPSFiltered = SWTFFT(figDeltaPS, decNum, wName, sigma);
    figDeltaPiPSFiltered = SWTFFT(figDeltaPiPS, decNum, wName, sigma);
    
    if isDisplay
        figure('Position', [100, 100, 2048, 1536]);
        colormap('gray');
        
        subplot(2, 2, 1);
        imagesc(figZeroPSFiltered, [0, 1]);
        title("Zero Phase-shift Filtered");
        
        subplot(2, 2, 2)
        imagesc(figPiPSFiltered, [0, 1]);
        title("\pi Phase-shift Filtered ");
        
        subplot(2, 2, 3)
        imagesc(figDeltaPSFiltered, [0, 1]);
        title("\delta Phase-shift Filtered");
        
        subplot(2, 2, 4)
        imagesc(figDeltaPiPSFiltered, [0, 1]);
        title("\delta + \pi Phase-shift Filtered")
    end
end

