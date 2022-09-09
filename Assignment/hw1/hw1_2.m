clear; clc

h1 = 0.1;
h2 = 0.01;
h3 = 0.001;
t_max = 60;
x0 = 0;
theta0 = 1.5;

for h = [h1, h2, h3]
    t = 0:h:t_max;

    [x_euler, theta_euler] = Euler2(x0, theta0, h, t);
    [x_heun, theta_heun] = Heun2(x_euler, theta_euler, theta0, x0, h, t);
    
    hh = num2str(h);
    figure
    subplot(221);
    plot(t, x_euler); hold on;
    plot(t, x_heun);
    legend('Euler' , 'Heun');
    xlabel('t'); ylabel('x');
    title(strcat('h=', hh));
    hold off;

    subplot(223);
    plot(t, theta_euler); hold on;
    plot(t, theta_heun);
    legend('Euler' , 'Heun');
    xlabel('t'); ylabel('\theta');
    title(strcat('h=', hh));
    hold off;

    subplot(2, 2, [2, 4]);
    plot(theta_euler, x_euler); hold on;
    plot(theta_heun, x_heun);
    legend('Euler' , 'Heun');
    xlabel('\theta'); ylabel('x');
    title(strcat('h=', hh));
    hold off;
end

