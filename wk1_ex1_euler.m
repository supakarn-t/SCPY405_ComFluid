clear;clc

global A B C d nu
d = 0.01;
rho = 8000;
rho_f = 1.22;
nu = 1.49e-5;
g = 9.8;

rho_bar = rho_f/rho;
A = 1+(rho_bar/2);
B = (1-rho_bar)*g;
C = 3*rho_bar/(4*d);
h = 0.01;
t_max = 10;
t = 0:h:t_max;
nt = length(t);

v0 = 0;
z0 = 0;
v_euler = zeros(nt, 1);
z_euler = zeros(nt, 1);
v_Heun = zeros(nt, 1);
z_Heun = zeros(nt, 1);

for i = 1:nt-1
    c_d = drag_coeff(v_euler(i), d, nu);
    f_euler = (B-C*c_d*abs(v_euler(i))*v_euler(i))/A;
    v_euler(i+1) = v_euler(i)+h*f_euler;
    z_euler(i+1) = z_euler(i)+h*v_euler(i);

%     f_Heun = (B-C*c_d*abs(v_Heun(i))*v_Heun(i))/A;
%     v_Heun(i+1) = v_Heun(i)+h*(f_euler(i+1)+f_Heun(i))/2;
%     z_Heun(i+1) = z_Heun(i)+h*(v_euler(i+1)+v_Heun(i))/2;
end

figure
subplot(221);plot(t, z_euler);title('Z - euler');
subplot(222);plot(t, v_euler);title('V - euler');
% subplot(223);plot(t, z_Heun);title('Z - Heun');
% subplot(224);plot(t, v_Heun);title('V - Heun');

% use ode45
tspan = [0, t_max];
y0 = [v0; z0];
[t, y] = ode45(@freeFall, tspan, y0);
vv_euler = y(:, 1);
zz_euler = y(:, 2);
subplot(221);hold on;plot(t,zz_euler);title('Z - euler');hold off
subplot(222);hold on;plot(t,vv_euler);title('V - euler');hold off
% subplot(221);hold on;plot(t,zz_euler);title('Z - Heun');hold off
% subplot(222);hold on;plot(t,vv_euler);title('V - Heun');hold off