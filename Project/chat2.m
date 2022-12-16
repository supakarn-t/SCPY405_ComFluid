% define the size of the grid
nx = 50;
ny = 50;

% define the domain size
Lx = 1;
Ly = 1;

% define the diffusion coefficient
k = 1e-2;

% define the time step size
dt = 1e-2;

% define the initial temperature field
T = zeros(ny, nx);

% define the boundary conditions
T_left = 0;
T_right = 1;
T_top = 0;
T_bottom = 0;

% set the boundary conditions
T(:,1) = T_left;
T(:,end) = T_right;
T(1,:) = T_top;
T(end,:) = T_bottom;

% define the grid spacing
dx = Lx/nx;
dy = Ly/ny;

% define the maximum number of iterations
maxIter = 1000;

% define the tolerance for convergence
tol = 1e-6;

figure;
    
% main loop
for iter = 1:maxIter
    % store the old temperature field
    T_old = T;
    
    % update the temperature field
    T(2:end-1,2:end-1) = T_old(2:end-1,2:end-1) + dt*k*((T_old(3:end,2:end-1)-2*T_old(2:end-1,2:end-1)+T_old(1:end-2,2:end-1))/dy^2 + (T_old(2:end-1,3:end)-2*T_old(2:end-1,2:end-1)+T_old(2:end-1,1:end-2))/dx^2);
    
    % plot the temperature field at each iteration
%     figure;
    imagesc(T);
    title(sprintf('Temperature Field at Iteration %d', iter));
    colorbar;
    xlabel('x');
    ylabel('y');
%     axis equal;
    drawnow
    % compute the residual
    res = max(max(abs(T-T_old)));
    
    % check for convergence
    if res < tol
        break;
    end
end
