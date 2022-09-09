function [x, theta] = Euler2(x0, theta0, h, t)

nt = length(t);
x = zeros(nt, 1);
theta = zeros(nt, 1);
x(1) = x0;
theta(1) = theta0;

    for i = 1:nt-1
        x(i+1) = x(i) + h*(-0.1*x(i) - sin(theta(i)));
        theta(i+1) = theta(i) + h*x(i);
    end
end

