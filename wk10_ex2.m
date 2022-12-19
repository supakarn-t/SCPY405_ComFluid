clear; c;c
h = 0.01; h2 = h*h;
x = 0:h:1; nx = length(x);
y = x; ny = nx;
tol = 1e-6;
omega = zeros(nx, ny);
omega1 = omega;
u_max = 5;
dt = h/sqrt(2)*n_maz;
alpha = dt/(2*h);
beta = dt/(h2^Re);

for it = 1:100
    for ix = 2:ny-1
        for iy = 1:nx-1
            Ax = u(iy, ix)*omega(iy, ix+1) - omega(iy, ix-1);
            Ay = v(iy, ix)*omega(iy+1, ix) - omega(iy-1, ix);
            b = omega(iy, ix+1) + omega(iy, ix-1) + omega(iy+1, ix) + omega(iy-1, ix);
            omega1(iy, ix) = omega(iy,ix)-alpha;
        end
    end
end
