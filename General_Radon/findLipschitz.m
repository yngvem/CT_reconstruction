function [ L ] = findLipschitz( n, e, theta, maxIt)
%FINDLIPSCHITZ Summary of this function goes here
%   Detailed explanation goes here
P = phantom(n);
L = norm(phantom(n), 'fro');
P = P./n;

diff = inf;
if not(exist('e', 'var'))
    e = 1e-5;
end
if not(exist('maxIt', 'var'))
    maxIt = 100;
end
if not(exist('theta', 'var'))
    theta = 1:180;
end

i = 0;


while diff/n>e && i < maxIt
    P = iradon(radon(P, theta), theta, 'linear', 'none');
    P = P(2:n+1, 2:n+1);
    L2 = norm(P, 'fro');
    P = P./L2;
    i = i+1
    diff = abs(L2-L);
    L = L2;
end

end

