function optimal_x = adaptive_FISTA(x0, F, prox, L, N, showIt, Lmax)
% adaptive_fista(x0, F, prox, L, N, showIt, Lmax) Solves the convex 
% optimization problem F(x) = f(x) + g(x), where f(x) is differentiable and 
% g(x) is not differentiable. The function uses the FISTA algorithm 
% modified with a restart scheme and starts backtracking for the Lipshitz 
% constant if it restarts two iterations in a row. It breaks f the  
% backtracking fails (L > Lmax). The function takes parameters:
%    x0: Initial guess
%    F: Optimization problem
%    prox: Proximal map of F
%    N: No. of iterations.
%    showIt: Show or hide iterations: (optional)
%            showIt = 0: Hide everything
%            showIt = 1: Show iteration number
%            showIt = 2: Show iteration number and display guess image
%    Lmax: Lipshitz constant stopping condition (optional)

%Set up initial variables
[m, n] = size(x0);
x = zeros(m, n, N);
x(:, :, 1) = x0;                                                            %Set x0
y = x;                                                                      %Declare variable for past iteration
t2 = 1;                                                                     %Momentum variable

if not(exist('Lmax', 'var'))
    Lmax = 16384;
end
if not(exist('showIt', 'var'))
    showIt = false;
end

if showIt == 2                                                              %Show iterations
    for i = 2:N
        t = t2;                                                             %Set t_i-1
        z = prox(y(:, :, i-1), L);                                          %Set iteration variable
        if F(z) < F(x(:,:,i-1))                                             %Test if iteration improves convergence
            x(:,:,i) = z;                                                   %Update x to current iteratoin
            t2 = 0.5*(1 + sqrt(1 + 4*t^2));                                 %Set t_i
            y(:, :, i) = x(:, :, i) +...
                        ((t-1)/t2)*(x(:, :, i) - x(:, :, i-1));             %Find correct linear combination of variables
        else
            disp('Restarting')
            x(:,:,i) = x(:,:,i-1);                                          %Start over again
            t2 = 1;                                                         %No momentum
            y(:, :, i) = x(:,:,i);                                          %Velocity 0
            if t == 1
                disp('Start backtracking');
                while L <= 16384 && F(z) > F(x(:,:,i-1))
                    L = 2*L;
                    z = prox(y(:, :, i-1), L);
                    s = sprintf('L = %g', L);
                    disp(s);
                end
                if L < Lmax                                                 %Test for improved fit                  
                    x(:,:,i) = z;                                           %Update iterative variables
                    t2 = 0.5*(1 + sqrt(1 + 4*t^2));
                    y(:, :, i) = x(:, :, i) + ...
                                ((t-1)/t2)*(x(:, :, i) - x(:, :, i-1));
                else
                    N = i;                                                  %Couldn't improve the fit
                    break
                end
            end
        end
        s = sprintf('Iteration no. %d', i);
        disp(s)
        imshow(x(:,:,i));
    end
elseif showIt == 1                                                          %Only show iteration number
   for i = 2:N
        t = t2;                                                             %Set t_i-1
        z = prox(y(:, :, i-1), L);                                          %Set iteration variable
        if F(z) < F(x(:,:,i-1))                                             %Test if iteration improves convergence
            x(:,:,i) = z;                                                   %Update x to current iteratoin
            t2 = 0.5*(1 + sqrt(1 + 4*t^2));                                 %Set t_i
            y(:, :, i) = x(:, :, i) + ...
                        ((t-1)/t2)*(x(:, :, i) - x(:, :, i-1));             %Find correct linear combination of variables
        else
            disp('Restarting')
            x(:,:,i) = x(:,:,i-1);                                          %Start over again
            t2 = 1;                                                         %No momentum
            y(:, :, i) = x(:,:,i);                                          %Velocity 0
            if t == 1
                disp('Start backtracking');
                while L <= 16384 && F(z) > F(x(:,:,i-1))
                    L = 2*L;
                    z = prox(y(:, :, i-1), L);
                    s = sprintf('L = %g', L);
                    disp(s);
                end
                if L < Lmax                                                 %Test for improved fit                  
                    x(:,:,i) = z;                                           %Update iterative variables
                    t2 = 0.5*(1 + sqrt(1 + 4*t^2));
                    y(:, :, i) = x(:, :, i) ...
                                + ((t-1)/t2)*(x(:, :, i) - x(:, :, i-1));
                else
                    N = i;                                                  %Couldn't improve the fit
                    break
                end
            end
        end
        s = sprintf('Iteration no. %d', i);
        disp(s)
   end
else                                                                        %No output
    for i = 2:N
        t = t2;                                                             %Set t_i-1
        z = prox(y(:, :, i-1), L);                                          %Set iteration variable
        if F(z) < F(x(:,:,i-1))                                             %Test if iteration improves convergence
            x(:,:,i) = z;                                                   %Update x to current iteratoin
            t2 = 0.5*(1 + sqrt(1 + 4*t^2));                                 %Set t_i
            y(:, :, i) = x(:, :, i) + ...
            ((t-1)/t2)*(x(:, :, i) - x(:, :, i-1));                         %Find correct linear combination of variables
        else
            disp('Restarting')
            x(:,:,i) = x(:,:,i-1);                                          %Start over again
            t2 = 1;                                                         %No momentum
            y(:, :, i) = x(:,:,i);                                          %Velocity 0
            if t == 1
                while L <= 16384 && F(z) > F(x(:,:,i-1))
                    L = 2*L;
                    z = prox(y(:, :, i-1), L);
                end
                if L < Lmax                                                 %Test for improved fit                  
                    x(:,:,i) = z;                                           %Update iterative variables
                    t2 = 0.5*(1 + sqrt(1 + 4*t^2));
                    y(:, :, i) = x(:, :, i) + ...
                    ((t-1)/t2)*(x(:, :, i) - x(:, :, i-1));
                else
                    N = i;                                                  %Couldn't improve the fit
                    break
                end
            end
        end
    end
end

optimal_x = x(:, :, 1:N);
end

