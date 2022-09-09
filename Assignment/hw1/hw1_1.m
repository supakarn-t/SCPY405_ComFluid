clear; clc

h1 = 0.1;
h2 = 1;
t_max = 10;
t1 = 0:h1:t_max;
t2 = 0:h2:t_max;
x0 = 10;

x_euler1 = Euler1(x0, h1, t1);
x_euler2 = Euler1(x0, h2, t2);

x_huen1 = Heun1(x_euler1, x0, h1, t1);
x_heun2 = Heun1(x_euler2, x0, h2, t2);

subplot(211);
plot(t1, x_euler1); hold on;
plot(t1, x_huen1);
legend('Euler' , 'Heun');
xlabel('t'); ylabel('x');
title('h = 0.1');
hold off;

subplot(212);
plot(t2, x_euler2); hold on;
plot(t2, x_heun2);
legend('Euler' , 'Heun');
xlabel('t'); ylabel('x');
title('h = 1');
hold off;

% ----- ode45 ----- %
% tspan = [0, t_max];
% y = ode45(@odeee, tspan, x0);
% xx = y;
% 
% subplot(221); hold on; plot(t1 ,xx); title('Euler h = 0.1'); hold off
% subplot(222); hold on; plot(t2 ,xx); title('Euler h = 1'); hold off
% subplot(223); hold on; plot(t1 ,xx); title('Heun h = 0.1'); hold off
% subplot(224); hold on; plot(t2 ,xx); title('Heun h = 1'); hold off