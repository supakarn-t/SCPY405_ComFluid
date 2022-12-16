function rho = computeDensity(x,y,h,mass,bc)
%COMPUTEDENSITY Computes the density of each particle using the SPH method
%   x,y: positions of the particles
%   h: smoothing length
%   mass: mass of each particle
%   bc: boundary conditions ('periodic' or 'non-periodic')

% Initialize the density array
rho = zeros(size(x));

% Loop over all pairs of particles
for i = 1:length(x)
    for j = i+1:length(x)
        % Compute the distance between the particles
        dx = x(i)-x(j);
        dy = y(i)-y(j);
        
        % Apply the boundary conditions
        if strcmp(bc,'periodic')
            dx = dx - round(dx);
            dy = dy - round(dy);
        end
        
        % Compute the kernel weight
        w = kernel(dx,dy,h);
        
        % Add the contribution to the density
        rho(i) = rho(i) + mass(j)*w;
        rho(j) = rho(j) + mass(i)*w;
    end
end
end
