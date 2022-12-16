% object falling into water

clc;clear;close all

% Simulation parameters
tEnd            = 10;        % time at which simulation ends
dt              = 0.01;      % timestep
m               = 0.5;       % particle mass
h               = 0.01;      % smoothing length
rho_to_p_const  = 0.1;       % equation of state constant
n_poly          = 5;         % polytropic index
nu              = 5;         % damping
k_wall          = 5000;

% tank_width = 10;             % width of the tank in meters
% tank_height = 5;             % height of the tank in meters
% tank_depth = 2;              % depth of the tank in meters
density = 1000;              % density of the water in kg/m^3
viscosity = 1e-3;            % viscosity of the water in Pa*s
object_position = [0, 0];    % initial position in x, y coordinates
object_velocity = [1, 0];    % initial velocity in x, y coordinates

% Create particles and define their initial locations

k = 1;
for px = 0 : 2*h : 0.2
    for py = 0 : 2*h : 1
        x(k,:) = [px py];
        k = k + 1;
    end
end

% num = 100;
% 
% x = sphSquare([0.2, 0.5, 0.6, 0.2], 1.75*h);
% % x = sphCircle([0.5, 0.8], 0.5, num, 2*h);
% % x = [x1; x0];

% plot(x(:,1), x(:,2), 'r.');
% hold on;
% % plot(x(num+1:end,1), x(num+1:end,2), 'b.');
% plot([-0.01,-0.01,1.01,1.01],[1,-0.01,-0.01,1.01],'r');
% hold off
% axis equal;xlim([-0.1 1.1]);ylim([-0.1 1.1]);
% title("i = "+i)
% return

N = size(x,1); % Number of particles
a = zeros(N,2);
v = zeros(N,2);
% K = ceil(tEnd/dt);
K = 200;
tic

for i = 1:K
    v = v + a * dt;
    x = x + v * dt;

    % update densities, pressures, accelerations
    rho = CalDensity(x, m, h);
%     rho = 1000*ones(N,1);
    P = rho_to_p_const * rho.^(1 + 1/n_poly);
%     P = rho*10*h;
    a = CalAcceleration(x, v, m, rho, P, nu, h);

    % apply contact force by the walls
    f1 = CalContactForce(x, k_wall);
    f_contact = f1;
    a = a + f_contact / m;

    plot(x(:,1), x(:,2), 'r.');
    hold on;
%     plot(x(num+1:end,1), x(num+1:end,2), 'b.');
    plot([-0.01,-0.01,1.01,1.01],[1,-0.01,-0.01,1.01],'r');
    hold off
    axis equal;xlim([-0.1 1.1]);ylim([-0.1 1.1]);
    title("i = "+i)
    drawnow
end
toc