function Im = FBP(x, theta, filter, cutoff)
% FBP(x, theta, filter, cutoff) calculates the filtered backprojection 
% solution of the Radon inversion problem with the parameters:
%    x: Sinogram
%    theta: Angles projected over
%    filter: Type of filter, standard 'ram-lak'
%          'ram-lak': Standard Ram-Lak filter
%          'shepp-logan': Shepp-Logan filter
%    cutoff: Cutoff frequency (0.5*precentage of signal to keep) (standard: 1)

if not(exist('filter', 'var'))
    filter = 'none';
end
if not(exist('cutoff', 'var'))
    cutoff = 1;
end


Fx = fft(x);                                                                %Calculate the discrete Fourier transform of the columns
[n, ~] = size(x);
y = [Fx(ceil(n/2)+1:end, :) ;...
     Fx(1:ceil(n/2), :)];                                                   %Split signal into more intuitive form

f = FBP_filter(n, filter, cutoff);                                          %Set filter
F = repmat(f, [1, length(theta)]);                                          %Place filter in matrix

y = F.*y;                                                                   %Apply filter

sF = [y(ceil(n/2):n, :);...
       y(1:floor(n/2), :)];                                                 %Restore signal into matlab-form
FsF = ifft(sF);                                                             %Inverse Fourier transform

Im = iradon(FsF, theta, 'linear', 'none');                                  %Return image
lessThan0 = Im(Im<0);
if lessThan0
    Im = Im+abs(min(lessThan0(:)));
    Im = Im/max(Im(:));
else
    Im = Im/max(Im(:));
end
    
end

