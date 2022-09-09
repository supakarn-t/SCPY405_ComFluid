function x = Euler1(x0, h, t)

nt = length(t);
x = zeros(nt, 1);
x(1) = x0;

    for i = 1:nt-1
        x(i+1) = x(i) - h*log(x(i));
    end
end

