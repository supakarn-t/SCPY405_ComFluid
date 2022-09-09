clear; clc
n = 100;
R = linspace(1, 4, n+2);
h = R(2)-R(1);
phiL = 1;
phiR = 64-24*log(4);
a = h./(2*R);
A = zeros(n);
b = zeros(n, 1);
A(1, 1) = -2; A(1, 2) = 1+a(2);
b(1) = 9*R(2)*h^2-(1-a(2))*phiL;
%ที่เป็น 2 เพราะว่า index ของ matlab เริ่มที่ 1 แต่ที่เราทำบนกระดานเริ่มที่ 0

for i = 2:n-1
    A(i, i-1) = 1-a(i+1);
    A(i, i) = -2;
    A(i, i+1) = 1+a(i+1);
    b(i) = 9*R(i+1)*h^2;
end

A(n, n-1) = 1-a(n+1); A(n, n) = -2;
b(n) = 9*R(n+1)*h^2 - (1+a(n+1))*phiR;
phi = [phiL; A\b; phiR];
plot(R, phi); xlabel('R'); ylabel('\phi')