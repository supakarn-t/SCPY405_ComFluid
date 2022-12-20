clear; clc
% heat flow with heat transfer at the walls

h = 0.02; dt = 0.0015; t_max = 10;
nx = 50; ny = nx;
[X,Y] = meshgrid(0:h:1, 0:h:1);

rho = 1.2; % density
% mu = 1.8e-5; % viscosity
k = 0.1; % thermal conductivity
cp = 1; % specific heat capacity
alpha = k/(rho*cp); % thermal diffusivity

T0 = 20; % initial temperature
T_top = 20; T_bottom = 50;
T_left = 20; T_right = 20;
H = 10; % heat transfer coefficient at the walls

T = T0*ones(ny+1,nx+1); % temperature (C)
u = zeros(ny+1, nx+1); % x-velocity (m/s)
v = zeros(ny+1, nx+1); % y-velocity (m/s)

T(1,:) = T_bottom;
T(end,:) = T_top;
T(:,1) = T_left;
T(:,end) = T_right;

% u(1,:) = 0; % top wall
% u(end,:) = 0; % bottom wall
% u(:,1) = 0; % left wall
% u(:,end) = 0; % right wall
% v(1,:) = 0; % top wall
% v(end,:) = 0; % bottom wall
% v(:,1) = 0; % left wall
% v(:,end) = 0; % right wall

figure;

for n = 1:200
    Fb = rho*alpha*(T-T0); % buoyancy force

    % velocity field
    for i = 2:ny
        for j = 2:nx
            u(i,j) = u(i,j) + dt*(1/rho)*(Fb(i,j)-Fb(i,j-1))/h;
            v(i,j) = v(i,j) + dt*(1/rho)*(Fb(i,j)-Fb(i-1,j))/h;
        end
    end

    % temperature field
    for i = 2:ny
        for j = 2:nx
            T(i,j) = T(i,j) + dt*alpha*((T(i+1,j)-2*T(i,j)+T(i-1,j))/h^2 ...
                + (T(i,j+1)-2*T(i,j)+T(i,j-1))/h^2 ...
                - (u(i,j)*(T(i,j+1)-T(i,j-1))/(2*h) ...
                + v(i,j)*(T(i+1,j)-T(i-1,j))/(2*h)));
        end
    end

    % wall temp
    T(1,:) = T(1,:) + dt*H*(T_bottom-T(1,:))/h; % top
    T(end,:) = T(end,:) + dt*H*(T_top-T(end,:))/h; % bottom
    T(:,1) = T(:,1) + dt*H*(T_left-T(:,1))/h; % left
    T(:,end) = T(:,end) + dt*H*(T_right-T(:,end))/h; % right

%     subplot(121);
    contourf(X,Y,T)
    set(gca, 'YDir', 'normal')
    colorbar
    xlabel('x (m)')
    ylabel('y (m)')
    title("i = "+n)
    axis equal

%     subplot(122);
%     imagesc(T)
%     set(gca, 'YDir', 'normal')
%     colorbar
%     xlabel('x (m)')
%     ylabel('y (m)')
%     title("i = "+n)

    drawnow
end
