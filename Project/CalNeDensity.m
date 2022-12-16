function rho = CalNeDensity(x, sorted_idx, m, h, n_neighbours)
N = size(x,1);

rho = zeros(N,1);

for i = 1 : N
    % find neighboring particles
    neighbour_idx = FindNeighbours(i, sorted_idx, n_neighbours);
    
    % initialize density with i = j contribution
    rho(i) = m * Kernel(0, h);
    
    for j = 1 : length(neighbour_idx)
        pair_idx = neighbour_idx(j);
        
        % calculate vector between two particles
        uij = x(i,:) - x(pair_idx,:);
        rho_ij = m * Kernel(uij, h);
        
        % add contribution to density
        rho(i) = rho(i) + rho_ij;
    end
end
end