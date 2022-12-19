%% Set up the domain and boundary conditions
L = 1; % Length of the cavity (m)
H = 1; % Height of the cavity (m)
T_top = 100; % Temperature at the top wall (C)
T_bottom = 50; % Temperature at the bottom wall (C)
T_left = 50; % Temperature at the left wall (C)
T_right = 50; % Temperature at the right wall (C)

%% Set up the discretization
Nx = 50; % Number of grid points in the x direction
Ny = 50; % Number of grid points in the y direction
dx = L/(Nx-1); % Grid spacing in the x direction (m)
dy = H/(Ny-1); % Grid spacing in the y direction (m)

%% Set up the matrices
A = zeros(Nx*Ny,Nx*Ny); % Coefficient matrix
b = zeros(Nx*Ny,1); % RHS vector

%% Assemble the matrices
for i = 1:Nx
    for j = 1:Ny
        % Compute the indices
        idx = j + (i-1)*Ny; % Current grid point
        idx_W = j + (i-2)*Ny; % West grid point
        idx_E = j + (i)*Ny; % East grid point
        idx_S = j-1 + (i-1)*Ny; % South grid point
        idx_N = j+1 + (i-1)*Ny; % North grid point
        
        % Compute the coefficients
        A(idx,idx) = 1;
        if i > 1
            A(idx,idx_W) = -1;
        end
        if i < Nx
            A(idx,idx_E) = -1;
        end
        if j > 1
            A(idx,idx_S) = -1;
        end
        if j < Ny
            A(idx,idx_N) = -1;
        end
        
        % Compute the RHS
        if i == 1
            b(idx) = T_left;
        elseif i == Nx
            b(idx) = T_right;
        elseif j == 1
            b(idx) = T_bottom;
        elseif j == Ny
            b(idx) = T_top;
        end
    end
end

%% Solve for the temperature field
T = A\b;

%% Reshape the solution into a 2D grid
T_grid = reshape(T,Ny,Nx);

plot(T_grid);