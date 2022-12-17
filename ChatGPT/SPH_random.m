% Set the number of particles and the size of the simulation domain
n = 100;
xmin = 0; xmax = 1;
ymin = 0; ymax = 1;

% Generate the initial positions and velocities of the particles
x = xmin + (xmax-xmin)*rand(n,1);
y = ymin + (ymax-ymin)*rand(n,1);
vx = zeros(n,1);
vy = zeros(n,1);

% Set the time step and the number of time steps to simulate
dt = 0.001;
nsteps = 1000;

% Set the physical properties of the particles
mass = ones(n,1);
h = 5;
rho0 = 1000;
k = 1000;
mu = 0.001;

% Set the boundary conditions
bc = 'periodic';

% Set the initial densities of the particles
rho = computeDensity(x,y,h,mass,bc);

% Set the initial pressures of the particles
P = k*(rho-rho0);

% Set the initial forces on the particles
[fx,fy] = computeForces(x,y,vx,vy,h,rho,P,mu,mass,bc);

% Loop over the time steps
for t = 1:nsteps
    % Update the positions of the particles
    x = x + dt*vx;
    y = y + dt*vy;
    
    % Update the velocities of the particles
    vx = vx + dt*fx./rho;
    vy = vy + dt*fy./rho;
    
    % Compute the density of each particle
    rho = computeDensity(x,y,h,mass,bc);
    
    % Compute the pressure of each particle
    P = k*(rho-rho0);
    
    % Compute the forces on each particle
    [fx,fy] = computeForces(x,y,vx,vy,h,rho,P,mu,mass,bc);

    % Plot
    scatter(x,y);
    axis equal;xlim([-3 3]);ylim([-3 3]);
    title("i = "+t)
    drawnow
end

% Plot the positions of the particles
% scatter(x,y);
