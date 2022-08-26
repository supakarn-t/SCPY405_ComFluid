function out = freeFall(~,y)
global A B C d nu

v = y(1);
out1 = (B-C*drag_coeff(v, d, nu)*abs(v)*v)/A;
out2 = v;
out = [out1; out2];