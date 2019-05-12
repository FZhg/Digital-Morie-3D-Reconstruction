%% This file contains function that can unwrap the phase

% unwrapPhase3, unwrap the phase by three-wavelength phase unwrapping
% Input:
%   wrappedPhase1 - wrapped phase according to lambda1
%   wrappedPhase2 - wrapped phase according to lambda2
%   wrappedPhase3 - wrapped phase according to lambda3
% Output:
%   unwrappedPhase - the unwrappedPhase
function unwrappedPhase =  unwrapPhase3(wrappedPhase1, wrappedPhase2, wrappedPhase3, lambda1, lambda2, lambda3)
    lambda12 = getRelativeWavelength(lambda1, lambda2);
    lambda23 = getRelativeWavelength(lambda2, lambda3);
    lambda123 = getRelativeWavelength(lambda12, lambda23);
    unwrappedPhase12 = unwrapSinglePhaseAB(wrappedPhase2, lambda2, lambda12, wrappedPhase1);
    unwrappedPhase23 = unwrapSinglePhaseBA(wrappedPhase2, lambda2, lambda23, wrappedPhase3);
    unwrappedPhase = unwrapSinglePhaseABC(wrappedPhase2, lambda2, lambda123, unwrappedPhase12, unwrappedPhase23);
end

% getRelativeWavelength
% Input:
%    lambdaA - the first wavelength
%    lambdaB - the second wavelength
% Output:
%   lambdaAB - the relative wavelength
function lambdaAB = getRelativeWavelength(lambdaA, lambdaB)
    lambdaAB =  lambdaA * lambdaB / abs(lambdaA - lambdaB);
end

% getRelativeWavelength
% Input:
%   phaseA - the first phase
%   phaseB - the second phase
% Output:
%   phaseAB - relative phase
function phaseAB = getRelativePhase(phaseA, phaseB)
    phaseAB = phaseA - phaseB;
    mask = sign(-sign(phaseAB) + 1) * 2 * pi;
    phaseAB = phaseAB +  mask;
end

% getPhaseFiltered
% Input:
%   phase - the phase to unwrap
%   lambda - the wavelenght of corresponding morrie pattern
%   relativePhase - the calculated relative phase
%   relativeLambda - the calculated relative wavelength
function phaseFiltered = getPhaseFiltered(phase, lambda, relativePhase, relativeLambda)
    phaseFiltered = phase +  2 * pi * round( (relativeLambda / lambda * relativePhase - phase) / (2 * pi));
end

% unwrapSinglePhaseAB
% Input:
%   phaseB - the phase to unwrap
%   lambdaB - the wavelenght of corresponding morrie pattern
%   relativeLambda - the calculated relative wavelength
%   phaseA - the wrapped phase for referrence
function phaseUnwrapped = unwrapSinglePhaseAB(phaseB, lambdaB, relativeLambda, phaseA)
    relativePhase = getRelativePhase(phaseA, phaseB);
    phaseUnwrapped = getPhaseFiltered(phaseB, lambdaB, relativePhase, relativeLambda);
end

% unwrapSinglePhaseBA
% Input:
%   phaseB - the phase to unwrap
%   lambdaB - the wavelenght of corresponding morrie pattern
%   relativeLambda - the calculated relative wavelength
%   phaseA - the wrapped phase for referrence
function phaseUnwrapped = unwrapSinglePhaseBA(phaseB, lambdaB, relativeLambda, phaseA)
    relativePhase = getRelativePhase(phaseB, phaseA);
    phaseUnwrapped = getPhaseFiltered(phaseB, lambdaB, relativePhase, relativeLambda);
end

% unwrapSinglePhaseABC
% Input:
%   phaseB - the phase to unwrap
%   lambdaB - the wavelenght of corresponding morrie pattern
%   relativeLambda - the calculated relative wavelength
%   phaseAB - the unwrapped phase for referrence
%   PhaseBC - the unwrapped phase for referrence
function phaseUnwrapped = unwrapSinglePhaseABC(phaseB, lambdaB, relativeLambda, phaseAB, phaseBC)
    relativePhase = getRelativePhase(phaseAB, phaseBC);
    phaseUnwrapped = getPhaseFiltered(phaseB, lambdaB, relativePhase, relativeLambda);
end