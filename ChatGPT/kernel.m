function [w,wx,wy] = kernel(dx,dy,h)
%KERNEL Computes the kernel weight and derivative for a pair of particles
%   dx,dy: distance between the particles
%   h: smoothing length
%   w: kernel weight
%   wx,wy: kernel derivative

r = sqrt(dx^2 + dy^2);

if r < h
    % Compute the kernel weight
    w = (h^2 - r^2)/(h^2*pi);
    % Compute the kernel derivative
    wx = -2*dx*w/r;
    wy = -2*dy*w/r;
else
    % Set the kernel weight and derivative to zero outside the smoothing length
    w = 0;
    wx = 0;
    wy = 0;
end
end
