function f = CalContactForce_box(x, k_wall)

N = size(x,1);
f = zeros(N,2);

for i = 1 : N
    xi = x(i,1);
    yi = x(i,2);

    % box located at x>0.5, x<0.6, and y<0.1

    if xi > 0.5 && xi < 0.51 && yi < 0.1 % box <<
        f(i,1) = -k_wall*abs(xi-0.5); 
    end

    if xi > 0.59 && xi < 0.6 && yi < 0.1 % box >>
        f(i,1) = k_wall*abs(0.6-xi); 
    end

    if xi > 0.5 && xi < 0.6 &&  yi > 0.09 && yi < 0.1 % box AA
        f(i,2) = k_wall*abs(yi-0.1); 
    end
end
