%% This file contains functions that help to extract phase
%% from 4 captured deformed and grid removed image; 

% Etract WrappedPhase and display the image according to paramter
%
% Input:
%   figZeroPS - the fig matrix with zero phase shift
%   figPiPS - the fig matrix with pi phase shift
%   figDeltaPS - the fig matrix with delta phase shift
%   figDeltaPiPS - the fig matrix with delta  + pi phase shift
%   ddecNum - the optimized decomposition number
%   
%
% Output:
%  wrappedPhase - the wrapped phase matrix
function wrappedPhase = extractWrappedPhaseSWTFFT(figZeroPSFiltered, figPiPSFiltered, figDeltaPSFiltered, figDeltaPiPSFiltered, delta, isDisplay)
    figZero =  (figPiPSFiltered - figZeroPSFiltered) /2;
    figDelta = (figDeltaPiPSFiltered - figDeltaPSFiltered) / 2;
    wrappedPhase = atan2d(figZero * sin(delta), figDelta - figZero * cos(delta));
    if isDisplay
        displayFig(wrappedPhase, "test for extracting wrapped phase")
    end
end
