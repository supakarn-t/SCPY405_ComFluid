% Define the dimensions of the cavity
lx = 1; % width of the cavity (m)
ly = 1; % height of the cavity (m)

% Define the properties of the fluid
rho = 1; % density (kg/m^3)
mu = 1; % viscosity (Pa*s)
k = 1; % thermal conductivity (W/m*K)
Pr = 0.7; % Prandtl number

% Define the temperature of the walls
Tleft = 0; % temperature at the left wall (C)
Tright = 100; % temperature at the right wall (C)
Ttop = 50; % temperature at the top wall (C)
Tbottom = 50; % temperature at the bottom wall (C)

% Define the grid size
nx = 50; % number of cells in the x-direction
ny = 50; % number of cells in the y-direction

% Define the grid
[x,y] = meshgrid(linspace(0,lx,nx+1), linspace(0,ly,ny+1));
dx = lx/nx; % grid size in the x-direction
dy = ly/ny; % grid size in the y-direction

% Define the initial temperature field
T = (Tleft+Tright)/2*ones(ny+1,nx+1); % initial temperature field

% Define the maximum number of iterations and the tolerance
maxIter = 1000; % maximum number of iterations
tol = 1e-6; % tolerance

% Solve the natural convection problem
for iter = 1:maxIter
    
    % Compute the temperature at the next time step
    Tnew = T;
    for i = 2:ny
        for j = 2:nx
            Tnew(i,j) = (T(i+1,j)+T(i-1,j)+T(i,j+1)+T(i,j-1))/4 ...
                        +(mu/k*(1/dx^2+1/dy^2))*(T(i+1,j)+T(i-1,j)+T(i,j+1)+T(i,j-1)-4*T(i,j)) ...
                        -rho*mu*(T(i,j+1)-T(i,j-1))/(2*k*dy) ...
                        -rho*mu*(T(i+1,j)-T(i-1,j))/(2*k*dx) ...
                        +rho*mu*Pr*(T(i+1,j)+T(i-1,j)-2*T(i,j))/(2*k*dx^2) ...
                        +rho*mu*Pr*(T(i,j+1)+T(i,j-1)-2*T(i,j))/(2*k*dy^2);
        end
    end
    
    % Set the boundary conditions
    Tnew(:,1) = Tleft;
    Tnew(:,nx+1) = Tright;
    Tnew(1,:) = Ttop;
    Tnew(ny+1,:) = Tbottom;

% Compute the residual
residual = norm(Tnew-T, 'fro')/norm(T, 'fro');

% Check the convergence
if residual < tol
    disp(['Converged after ', num2str(iter), ' iterations.'])
    break;
end

% Update the temperature field
T = Tnew;

% Plot the temperature field
contourf(x,y,T)
title("i = "+iter)
xlabel('x (m)')
ylabel('y (m)')
colorbar
drawnow
end

