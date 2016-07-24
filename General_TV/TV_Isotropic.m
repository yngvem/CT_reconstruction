function tv = TV_Isotropic(b)
% TV_I(b) Returns the isotropic total variation seminorm of the image I and
% takes the parameter:
%    I: Image for TV-norm calculation

tv = norm((b(1:end-1, 1:end-1) - b(2:end, 1:end-1)).^2 + ...
          (b(1:end-1, 1:end-1) - b(1:end-1, 2:end)).^2, 'fro') + ...
      norm(b(1:end-1, end) - b(2:end, end), 1) + ...
      norm(b(end, 1:end-1) - b(end, 2:end), 1);
    
end

