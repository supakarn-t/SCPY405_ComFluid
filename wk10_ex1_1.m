clear; clc
h = 0.01;
x = 0:h:1; nx = length(x);
u = 0.1;
dt = 0.01*h/u;

p0 = exp(-1000*(x-0.1).^2);
p1 = p0; p2 = p0;
alpha = u*dt/(2*h);

for it = 1:1000
    for ix = 2:nx-1
%         p2(ix) = p(ix)-alpha*(p(ix+1)-p(ix-1));
        p1(ix) = p0(ix)-3*beta*(p0(ix+1)-p0(ix-1));
    end
%     p2(1) = p(1)-alpha*(p(2)-p(nx));
%     p2(nx) = p(nx)-alpha*(p(1)-p(nx-1));
    p = p2;
    plot(x, p);axis([0 1 -5 5]);title("it = " + it); drawnow;
end