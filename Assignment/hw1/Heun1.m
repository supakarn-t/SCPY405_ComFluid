function x = Heun1(x_euler, x0, h, t)

nt = length(t);
x = zeros(nt, 1);
x(1) = x0;

    for i = 1:nt-1
        x(i+1) = x(i) - h*(log(x(i)) + log(x_euler(i+1)))/2;
    end
end

