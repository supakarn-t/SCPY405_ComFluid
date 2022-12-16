function a = CalNeAcceleration(x, sorted_idx, v, m, rho, P, nu, h, k_wall, n_neighbours)
N = size(x,1);

% initialize accelerations
a = zeros(N, 2); 

% add damping and gravity
a = a - nu * v + repmat([0 -9.8*m], N, 1);

% add pressure
for i =1: N
    curr_idx = sorted_idx(i);
    neighbour_idx = sorted_idx(max(i-n_neighbours,1) : min(i+n_neighbours,N));
    
    for j = 1 : length(neighbour_idx)
        pair_idx = neighbour_idx(j);
        
        % calculate vector between two particles
        uij = x(curr_idx, :) - x(pair_idx, :);
        
        % calculate acceleration due to pressure
        p_a = -m * (P(curr_idx)/rho(curr_idx)^2 + P(pair_idx) / rho(pair_idx)^2) ...
            * GradKernel(uij, h);
        
        a(curr_idx, :) = a(curr_idx, :) + p_a;
    end
    
    f = CalculateContactForceOneParticle(x(curr_idx,:), k_wall);
    a(curr_idx, :) = a(curr_idx, :) + f/m; 
end
end