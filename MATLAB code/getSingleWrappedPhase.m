%% This file contains the function  that repeat the whole process to extract the wrapped phase for a
%% specific morrie pattern wavelength

% getSingleUnwrappedPhase, this function calculate a single wrapped phase
% use previous functions
% Input:
%   pitch - the pitch of the fringe pattern
%   lambda - the wavelength of the morrie pattern
% Output:
%   wrappedPhase - the wrapped Phase

function wrappedPhase = getSingleWrappedPhase(pitch)
    [~, patternPath] = generatePattern(2048, 1536, 50, 200, pitch, 0, 1);
    prompt = 'the pattern path is ' + patternPath + '.\nPlease paste the captured image directory path below:\n';
    figPath = input(char(prompt));
    [figZeroPS, figPiPS, figDeltaPS, figDeltaPiPS] = digitalMorieSuperimpose(figPath, patternPath, 1, false);     
    decum = input(char("Please enter the decomposition level: \n"));
    dampingFactor = input(char("please enter the damping factor: \n"));
    [figZeroPSFiltered, figPiPSFiltered, figDeltaPSFiltered, figDeltaPiPSFiltered] = removeGridSWTFFT(figZeroPS, figPiPS, figDeltaPS, figDeltaPiPS, decum, 'db5', dampingFactor, false);
    delta = 1 / pitch * 2 * pi;
    wrappedPhase = extractWrappedPhaseSWTFFT(figZeroPSFiltered, figPiPSFiltered, figDeltaPSFiltered, figDeltaPiPSFiltered, delta, false);
end