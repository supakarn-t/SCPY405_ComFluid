clear; clc

h = 0.05; h2 = h*h;
x = 0:h:1; nx = length(x);
y = 0:h:1; ny = length(y);

alpha = cos(pi/nx) + cos(pi/ny);
alpha2 = alpha*alpha;
beta = (8 - 4*sqrt(4-alpha2))/alpha2;

psi = zeros(ny, nx);
w = zeros(ny, nx);
w(end, :) = -2/(3*h);

for i = 1:1000
    for iy = 2:ny-1
        w(iy, 1) = (-psi(iy-1, 2) + 8/3*psi(iy, 2) - psi(iy+1, 2) - 2/3*psi(iy, 3))/h2;
        w(iy, nx) = (-psi(iy-1, nx-1) + 8/3*psi(iy, nx-1) - psi(iy+1, nx-1) - 2/3*psi(iy, nx-2))/h2;
        
        for ix = 2:nx-1
            psi(iy, ix) = psi(iy, ix) + beta*0.25*(psi(iy-1, ix) + psi(iy+1, ix) + psi(iy, ix-1) + psi(iy, ix+1) -4*psi(iy, ix) - h2);
        
        end
    end
end

subplot(211)
imagesc(x, y, w); colorbar;
set(gca, 'YDir', 'normal');
title('w');

subplot(212)
imagesc(x, y, psi); colorbar;
set(gca, 'YDir', 'normal');
title('psi');

% w(iy, ix) = w(iy, ix) + beta*0.25*(w(iy-1, ix) + w(iy+1, ix) + w(iy, ix-1) + w(iy, ix+1) -4*psi(iy, ix) - h2);