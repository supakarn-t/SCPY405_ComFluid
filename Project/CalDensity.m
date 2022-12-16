function rho = CalDensity(x, m, h)
N = size(x,1);
rho = zeros(N,1);

for i = 1 : N    
   % initialize density with i = j contribution
    rho(i) = m * Kernel(0, h);
    
    for j = i+1 : N
        % calculate vector between two particles
        uij = x(i,:) - x(j,:);
        rho_ij = m * Kernel(uij, h);
        % add contribution to density
        rho(i) = rho(i) + rho_ij;
        rho(j) = rho(j) + rho_ij;
    end
end
