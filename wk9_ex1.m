clear; clc

D = 0.1;
dt = 0.5;
h = 1;

alpha = D*dt/h^2;
beta = -alpha; % A & C
gamma = 1 + 2*alpha; % B

n = 100;
u = zeros(n, 1);
u(50) = 1;

A = zeros(n, n);
A(1, 1) = gamma;
A(1, 2) = beta;
A(end, end-1) = beta;
A(end, end) = gamma;

for i = 2:n-1
    A(i, i) = gamma;
    A(i, i-1) = beta;
    A(i, i+1) = beta;
end

A = sparse(A);

for it = 1:n
    u = A\u;
    plot(u);
    title("it = " + it);
    axis([0 100 0 1])
    pause(0.1)
end