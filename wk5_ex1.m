clear; clc

n = 200;
x = linspace(-10, 10, n);
y = linspace(-10, 10, n);
[X, Y] = meshgrid(x, y);
z = X + 1i*Y;

%Uniform flow
U = 1;
alpha = pi/4;
w = U*z*exp(-1i*alpha);
phi = real(w);
psi = imag(w);

subplot(221);
contour(x, y, phi, 10, 'Color', 'r');
hold on
contour(x, y, psi, 10, 'Color', 'b');
hold off
axis equal
legend('phi', 'psi');

%Source Flow

%Vortex Flow
gamma = 1;


%Doublet Flow

