function df = unregularised_gradient(x, b, theta)
% unregularised_gradient(x, b, theta) returns the gradient of the 
% unregularised Radon inversion residual. It takes the parameters:
%    x: Image guess
%    b: Observed sinogram
%    theta: Angles to project over

    n = length(x);
    Rx = radon(x, theta); % Rf
    RRx = iradon(Rx-b, theta, 'linear', 'none'); %(R*(Rx-b))
    df = RRx(2:n+1, 2:n+1); %Crop to get right size
end

