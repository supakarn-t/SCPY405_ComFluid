clear; clc

% Pipe Flow and Open Channel Flow
h = 0.01; h2 = h*h;
z = 0:h:1; y = 0:h:1;
[Z,Y] = meshgrid(z,y);
nz = length(z); ny = length(y);
U = zeros(ny, nz);

for i = 1:10000
    for iz = 2:nz-1
        for iy = 2:ny-1
            U(iy,iz) = (h2 + U(iy+1,iz) + U(iy-1,iz) + U(iy,iz+1) + U(iy,iz-1))/4;
        end
    end
    U(end,:) = U(end-1,:);
end

imagesc(z, y, U); colorbar;
set(gca, 'YDir', 'normal')
xlabel('Z'); ylabel('Y'); axis image