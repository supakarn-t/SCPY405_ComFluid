function [fx,fy] = computeForces(x,y,vx,vy,h,rho,P,mu,mass,bc)
%COMPUTEFORCES Computes the forces on each particle using the SPH method
%   x,y: positions of the particles
%   vx,vy: velocities of the particles
%   h: smoothing length
%   rho: densities of the particles
%   P: pressures of the particles
%   mu: viscosity coefficient
%   mass: mass of each particle
%   bc: boundary conditions ('periodic' or 'non-periodic')

% Initialize the force arrays
fx = zeros(size(x));
fy = zeros(size(y));

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
        
        % Compute the kernel weight and derivative
        [w,wx,wy] = kernel(dx,dy,h);
        
        % Compute the pressure and viscosity forces
        fp = -mass(j)*(P(i)/(rho(i)^2) + P(j)/(rho(j)^2))*wx;
        fv = mu*(vx(j)-vx(i))*wx + mu*(vy(j)-vy(i))*wy;
        
        % Add the forces to the total forces
        fx(i) = fx(i) + fp + fv;
        fy(i) = fy(i) + fp + fv;
        fx(j) = fx(j) - fp - fv;
        fy(j) = fy(j) - fp - fv;
    end
end
end
