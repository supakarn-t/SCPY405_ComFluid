clear; clc

h = 0.1; h2 = h*h; % h น้อยลง รูปจะ smooth
x = -3:h:3; y = -2:h:2;
nx = length(x); ny = length(y);
w = -1;
iwx = find(x == 1); iwy = find(y == 1); % w=1 at x=1 , y=1

% ----- Jacobi -----%
fj0 = zeros(ny, nx); fj1 = fj0;
for i = 1:10000
    for ix = 2:nx-1
        for iy = 2:ny-1
            fj1(iy, ix) = 0.25*(fj0(iy, ix-1) + fj0(iy, ix+1) + fj0(iy-1, ix) + fj0(iy+1, ix));
            if ix == iwx && iy == iwy
                fj1(iy, ix) = fj1(iy, ix) - 0.25*h2*w;
            end
        end
    end
    fj0 = fj1;
end


subplot(131)
imagesc(x, y, fj1); colorbar;
title('Jacobi')
set(gca, 'YDir', 'normal')
hold on; contour(x, y, fj1, 50, 'Color', 'w'); hold off


% ----- Gauss-Seidel ----- %
fg0 = zeros(ny, nx); fg1 = fg0;
for i = 1:10000
    for ix = 2:nx-1
        for iy = 2:ny-1
            fg1(iy, ix) = 0.25*(fg1(iy, ix-1) + fg0(iy, ix+1) + fg1(iy-1, ix) + fg0(iy+1, ix));
            if ix == iwx && iy == iwy
                fg1(iy, ix) = fg1(iy, ix) - 0.25*h2*w;
            end
        end
    end
    fg0 = fg1;
end
subplot(132)
imagesc(x, y, fg1); colorbar;
title('Gauss-Seidel')
set(gca, 'YDir', 'normal')
hold on; contour(x, y, fg1, 50, 'Color', 'w'); hold off


% ----- SOR ----- %
fs0 = zeros(ny, nx); fs1 = fs0;
m = nx; n = ny;
alpha = cos(pi/m) + cos(pi/n);
beta = (8 - 4*sqrt(4-alpha^2))/alpha^2;
for i = 1:10000
    for ix = 2:nx-1
        for iy = 2:ny-1
            if beta >= 1 && beta < 2
                fs1(iy, ix) = fs0(iy, ix) + 0.25*beta*(fs1(iy, ix-1) + fs0(iy, ix+1) + fs1(iy-1, ix) + fs0(iy+1, ix) - 4*fs0(iy, ix));
                if ix == iwx && iy == iwy
                    fs1(iy, ix) = fs1(iy, ix) - 0.25*beta*h2*w;
                end
            end
        end
    end
    fs0 = fs1;
end
subplot(133)
imagesc(x, y, fs1); colorbar;
title('SOR')
set(gca, 'YDir', 'normal')
hold on; contour(x, y, fs1, 50, 'Color', 'w'); hold off