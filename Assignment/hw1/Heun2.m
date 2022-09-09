function [x, theta] = Heun2(x_euler, theta_euler, theta0, x0, h, t)

nt = length(t);
x = zeros(nt, 1);
theta = zeros(nt, 1);
x(1) = x0;
theta(1) = theta0;

    for i = 1:nt-1
        f1 = -0.1*x(i) - sin(theta(i));
        f2 = -0.1*x_euler(i+1) - sin(theta_euler(i+1));

        x(i+1) = x(i) + h*(f1 + f2)/2;
        theta(i+1) = theta(i) + h*(x(i) + x_euler(i+1))/2;
    end
end

