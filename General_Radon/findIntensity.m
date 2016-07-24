function [I] = findIntensity( R, p, n )
%FINDINTENSITY Summary of this function goes here
%   Detailed explanation goes here
m = n/16;
R = mean(R(:)/m);
I = exp(mean(R))/((p*R)^(2/3));
end

