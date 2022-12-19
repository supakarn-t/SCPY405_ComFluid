clear; clc
a = 1;
b = 0.7;
yp = 0.199;
xp = b - sqrt(a*a-yp*yp);
theta = 0:360;
xa = a*cosd(theta) + xp;
ya = a*sind(theta) + yp;

plot(xa, ya);axis image

n = length(theta);
xa2 = xa;
ya2 = ya;
for i = 1:n
    zp = xa(i) + 1i*ya(i);
    z = zp + b^2/zp;
    xa2(i) = real(z);
    ya2(i) = imag(z);
end
hold on;
plot(xa2, ya2, 'k--');
hold off