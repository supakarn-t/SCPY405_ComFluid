clear;clc

R = linspace(1, 4, 10);
phi = R.^3 - 24*log(R);
U = 3*R.^2 - 24./R;

subplot(211);plot(R, phi);title('Phi');
subplot(212);plot(R, U);title('U');

theta = linspace(0, 2*pi, 100);
[RR, Theta] = meshgrid(R, theta);
phi_RR = RR.^3 - 24*log(RR);
U_RR = 3*RR.^2 - 24./RR;
x = RR.*cos(Theta);
y = RR.*sin(Theta);

figure(2);
subplot(211);surf(x, y, phi_RR);view(2);axis image;shading flat;title('Phi_');
subplot(212);surf(x, y, U_RR);view(2);axis image;shading flat;title('U_');