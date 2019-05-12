%% This file contains the funtion that export our unwrapped phase to STL file

% exportSTL
% input:
%   unwrappedPhase - the phase unwrapped
%   lambda - the wavelength of morrie pattern
%   isDisplay
% Output:
%   STLModel - 
%   STLModelPath - 
function [STLModel, STLModelPath] = exportSTL(unwrappedPhase, lambda, isDisplay)
    h = lamdba / (2 * pi) * unwrappedPhase;
    if isDisplay
        surf(h);
    end
end