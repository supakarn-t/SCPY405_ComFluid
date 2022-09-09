clear; clc

% --- Uniform Flow --- %
x = linspace(-10, 10, 10); y = x;
[X,Y] = meshgrid(x, y);
U = 1; alpha = 0;

psi = U*(Y*cosd(alpha) - X*sind(alpha));
subplot(421); contour(x, y, psi, 20); title('Uniform Flow');

vx = U*cosd(alpha)*ones(size(X));
vy = U*sind(alpha)*ones(size(X));
subplot(422); quiver(X, Y, vx, vy);


% --- Source Flow --- %
x = linspace(-10, 10, 10); y = x;
[X,Y] = meshgrid(x, y);
L = 10; x0 = 0; y0 = 0;

theta = angle(X+1i*Y);
psi = L/(2*pi) * atan2(Y-y0, X-x0);
subplot(423); contour(x, y, psi); title('Source Flow');

R2 = (X-x0).^2 + (Y-y0).^2;
vx = L/(2*pi) * (X-x0)./R2;
vy = L/(2*pi) * (Y-y0)./R2;
subplot(424); quiver(X, Y, vx, vy);

%Uniform + Source
x = linspace(-10, 10, 1000); y = x;
[X,Y] = meshgrid(x, y);

psi1 = U*(Y*cosd(alpha) - X*sind(alpha)) + L/(2*pi) * mod(atan2(Y-y0, X-x0),2*pi);
psi2 = U*(Y*cosd(alpha) - X*sind(alpha)) + L/(2*pi) * atan2(Y-y0, X-x0);
subplot(425); contour(x, y, psi1, 15); title('Uniform + Source');
subplot(426); contour(x, y, psi2, 20); title('Uniform + Source');

R2 = (X-x0).^2 + (Y-y0).^2;
vx = L/(2*pi) * (X-x0)./R2;
vy = L/(2*pi) * (Y-y0)./R2;
% subplot(424); quiver(X, Y, vx, vy);
% subplot(424); imagesc(theta); colorbar;

% --- Doublet flow --- %
k = 40; x0 = 0; y0 = 0;
R2 = (X-x0).^2+(Y-y0).^2;
psi = -k/(2*pi) * (Y-y0)./R2;
subplot(427); contour(x, y, psi, 100); title('Doublet Flow');

psi = U*(Y*cosd(alpha) - X*sind(alpha));
psi = psi-k/(2*pi)*(Y-y0)./R2;
subplot(428); contour(x,y,psi,50);
hold on; contour(x,y,psi,[0,0]); hold off
axis image