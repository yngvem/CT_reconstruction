function f = FBP_filter(n, filter, cutoff)
% FBP_filter(n, filter, cutoff) calculates the correct filter to use with 
% filtered back projection. It takes the parameters:
%    n: Length of signal
%    filter: Type of filter (standard: ram-lak)
%           'ram-lak': Standard Ram-Lak filter
%           'shepp-logan': Shepp-Logan filter
%    cutoff: Cutoff frequency (0.5*precentage of signal to keep) (standard: 1)

if not(exist('filter', 'var'))
    filter = 'ram-lak';
end
if not(exist('cutoff', 'var'))
    cutoff = 1;
end

b = n/2*cutoff;                                                               %Set cutoff frequency
f = abs(0:floor(n/2))';                                                     %Generate absolute value filter
f(f > b) = 0;                                                               %Remove frequencies

if strcmp(filter, 'shepp-logan')
    filter_type = @(x) sinc(x/2);                                           %Set Shepp-Logan filter
else
    filter_type = @(x) 1;                                                   %Set Ram-Lak filter
end

f = f.*filter_type(f/b);                                                    %Apply filter type
f = [flipud(f(2:end)); f];                                                  %Generate complete filter

end