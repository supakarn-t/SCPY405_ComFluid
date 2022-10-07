clear; clc

h = 0.1;
xx = 2.5; yy = 1.5; l = 1;
x = 0:h:6; y = 0:h:4;
nx = length(x); ny = length(y);
psi = zeros(ny, nx);

for i = 1:100
    psi(1, :) = 1;
    psi(end, :) = 1;
    for ix = 2:nx-1
        for iy = 2:ny-1
            if (x(ix) >= xx && x(ix) <= xx+l) && (y(iy) >= yy && y(iy) <= yy+l)
                psi(iy, ix) = 0;
            elseif y(iy) ~= 2
                psi(iy, ix) = (psi(iy+1,ix) + psi(iy-1,ix) + psi(iy,ix+1) + psi(iy,ix-1))/4;
            end
        end
    end
    psi(:, 1) = psi(:, 2);
    psi(:, end) = psi(:, end-1);
end

subplot(121);
contour(x, y, psi, 50); colorbar;
xlabel('X'); ylabel('Y');

subplot(122);
imagesc(x, y, psi); colorbar;
xlabel('X'); ylabel('Y');

