%% Remove stipes and other noises in the superimposed images by 
%% SWT-FFT filtering method.
%% Input:
%%  fig    - the superimposed figure matrix
%%  decNum - the decomposition level number, an interger
%%  wname  - the wavelt function name, 'db5', 'db12'
%%  sigma  - the gaussian damping factor
function figFiltered = SWTFFT(fig, decNum, wname, sigma)
    % wavelet decompostion
    [A, H, V, D] = swt2(fig, decNum, wname);
    
    % fourier transform
    HDamped = zeros(size(H)); % only need to look at the horizontal coeffecient
    
    for i = 1:decNum
        % FFT
        HFFTed = fft(H(:, :, i));
        HFFTed = fftshift(HFFTed);
        [M, N] = size(HFFTed);
        
        % damping of horizontal stipe
        gaussianDampingX = -floor(M / 2) : -floor(M / 2) + M  - 1;
        gaussianDampingY = normpdf(gaussianDampingX, 0, sigma);
        gaussianDamping2D = repmat(gaussianDampingY', 1,  N);
        
       HFFTed = HFFTed .* gaussianDamping2D;
       
       %inverse FFT
       HFFted = ifftshift(HFFTed);
       HDamped(:, :, i) = ifft(HFFTed);
    end
    
    % wavelet reconstruction
    figFiltered = iswt2(A, HDamped, V, D, wname);
 end