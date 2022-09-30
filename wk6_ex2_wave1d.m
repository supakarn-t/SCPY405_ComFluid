clear; clc

h = 0.001; x = 0:h:1; a = 1e-5;
dt = h/a;
c = a*dt/h; c2 = c*c;
nx = length(x);
i = find(x >= 0.2 & x <= 0.6);
u0 = zeros(nx, 1);
u0(i) = sin(2*pi*(x(i)-0.2)/0.4);
u1 = u0;
i = i+1;
u1(i) = sin(2*pi*(x(i)-a*dt-0.2)/0.4);
u2 = u0;

for it = 1:1000
    for ix = 2:nx-1
        u2(ix) = 2*u1(ix) + c2*(u1(ix-1) - 2*u1(ix) + u1(ix+1)) - u0(ix);
    end
    u0 = u1; u1 = u2;
    plot(x, u1); axis([0 1 -1 1]); drawnow;
end