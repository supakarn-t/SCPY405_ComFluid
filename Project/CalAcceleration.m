function a = CalAcceleration(x, v, m, rho, P, nu, h)
% initialize accelerations
N = size(x,1);
a = zeros(N, 2); % add damping and gravity

a = a - nu * v + repmat([0 -9.8*m], N, 1);

% add pressure
for i =1: N
    for j = i+1 : N
        % calculate vector between two particles
        uij = x(i, :) - x(j, :);
        
        % calculate acceleration due to pressure
        p_a = -m * (P(i)/rho(i)^2 + P(j)/rho(j)^2) * GradKernel(uij, h);
        a(i, :) = a(i, :) + p_a;
        a(j, :) = a(j, :) - p_a;
    end
end
