clear; clc
n = 10;
a = 1;
U = 1;
i = 1:n-1;
phi = (10-i)*pi/10;
r = a*sin(phi);
z = a*cos(phi);
plot(z, r, 'o'); axis equal;

L = 2*0.8*a;
s = L/n;
zp = -0.8*a + (0:n)*s;
A = zeros(n);
b = zeros(n, 1);
for i = 1:n-1
    for j = 1:n
        d_ij = sqrt(r(i)^2 + (z(i)-zp(j))^2);
        d_ij1 = sqrt(r(i)^2 + (z(i)-zp(j+1))^2);
        A(i, j) = d_ij - d_ij1;
    end
    b(i) = r(i)^2/2;
end

Q = A\b;
m = 100;
zz = linspace(-10, 10, m);
rr = linspace(0, 10, m);
psi = zeros(m);
for ir = 1:m
end
