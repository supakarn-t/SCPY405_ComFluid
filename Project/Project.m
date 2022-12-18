% object falling into water

clc;clear;close all

% Simulation parameters
tEnd            = 10;        % time at which simulation ends
dt              = 0.01;      % timestep
m               = 0.5;       % particle mass
m1              = 1.0;       % particle mass
h               = 0.01;      % smoothing length
rho_to_p_const  = 0.1;       % equation of state constant
n_poly          = 5;         % polytropic index
nu              = 5;         % damping
k_wall          = 5000;
n_neighbours    = 40;

% Create particles and define their initial locations
num = 50;

x1 = sphSquare([0, 0.6, 0.4, 0.3], 2*h);
x2 = sphSquare([0.04, 0, 0.96, 0.2], 2*h);
x3 = sphSquare([0, 0, 0.01, 0.6], 2*h);
% x1 = sphCircle([0.5, 0.8], 0.1, num, 2*h);
x = [x1; x2; x3];

N = size(x,1);
a = zeros(N,2);
v = zeros(N,2);

K = 1000;

tic

for i = 1:K
    v = v + a * dt;
    x = x + v * dt;

    % update densities, pressures, accelerations    
%     rho = CalDensity(x, m, h);
%     P = rho_to_p_const * rho * (1 + 1/n_poly);
    rho = 1000*ones(N,1);
    P = rho*10*h;
    a = CalAcceleration(x, v, m, rho, P, nu, h);
    
    % apply contact force by the walls
    f_contact = CalContactForce(x, k_wall);
    a = a + f_contact / m;


    plot(x(:,1), x(:,2), 'bo');
%     plot(x(1:num,1), x(1:num,2), 'r.');
    hold on;
%     plot(x(num+1:end,1), x(num+1:end,2), 'bo');
    plot([.41,.41,.43,.43,.41],[1,.65,.65,1,1],'k');
    plot([.43,.02,.02,.04,.04,.43,.43],[.59,.59,.02,.02,.57,.57,.59],'k');
    plot([-0.01,-0.01,1.01,1.01,-0.01],[1,-0.01,-0.01,1,1],'k');
    hold off
    axis equal;xlim([-0.1 1.1]);ylim([-0.1 1.1]);
    title("i = "+i)
%     return
    drawnow
end

toc