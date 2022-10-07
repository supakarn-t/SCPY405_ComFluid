clear; clc

h = 0.01;
nu = 1e-6;
y = 0:h:1; ny = length(y);
dt = h*h/(2*nu); tmax = 500000;
nt = floor(tmax/dt)+1;
t = (1:nt-1)*dt;
R = nu*dt/(h*h);
u0 = 1;
u = zeros(ny,nt);
u(end,:) = u0;

for it = 1:nt
    for iy = 2:ny-1
        u(iy,it+1) = u(iy,it) + R*(u(iy-1,it) - 2*u(iy,it) + u(iy+1,it));
    end 
end

imagesc(t, y, u); colorbar;
set(gca, 'YDir', 'normal')
xlabel('time (s)'); ylabel('y (m)');