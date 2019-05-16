%%  This file contains function that can calculate the Morie Wavelength according to the system geometric parameters

function lambda = getMorieWavelengthGeo(theta, pitch)
    lambda = pitch / tan(theta);
end