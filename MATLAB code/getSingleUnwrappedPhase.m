%% This file contains the function  that repeat the whole process to extract the wrapped phase for a
%% specific morrie pattern wavelength

% getSingleUnwrappedPhase, this function calculate a single wrapped phase
% use previous functions
% Input:
%   lambda - the wavelength of the morrie pattern
% Output:
%   wrappedPhase - the wrapped Phase

function wrappedPhase = getSingleUnwrappedPhase(lambda)
    [~, patternPath] = generatePattern(2048, 1536, 50, 200, lambda, 0, 1);
    prompt = 'the pattern path is ' + patternPath + '.\nPlease paste the captured image directory path below:\n';
    figPath = input(char(prompt));
    [figZeroPS, figPiPS, figDeltaPS, figDeltaPiPS] = digitalMorieSuperimpose(figPath, patternPath, 1, false);
    % TO-DO optimization
    decum = input(char("Please enter the decomposition level"));
    dampingFactor = input(char("please enter the damping factor"));
    [figZeroPSFiltered, figPiPSFiltered, figDeltaPSFiltered, figDeltaPiPSFiltered] = removeGridSWTFFT(figZeroPS, figPiPS, figDeltaPS, figDeltaPiPS, 3, 'db5', 20, false);
    delta = 1 / lambda * 2 * pi;
    wrappedPhase = extractWrappedPhaseSWTFFT(figZeroPSFiltered, figPiPSFiltered, figDeltaPSFiltered, figDeltaPiPSFiltered, delta, false);
end