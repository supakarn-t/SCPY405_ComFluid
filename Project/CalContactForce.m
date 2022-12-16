function f = CalContactForce(x, k_wall)
% The walls are located at x<0, x>1, and y<0

N = size(x,1);
f = zeros(N,2);

for i = 1 : N
    xi = x(i,1);
    yi = x(i,2);

    if x(i,1) < 0
        f(i,1) = -k_wall*xi;    % x-positive force
%         f(i,2) = 10*abs(yi);
    elseif x(i,1) > 1
        f(i,1) = k_wall*(1-xi); % x-negative force
%         f(i,2) = 10*abs(yi);
    end
    
    if x(i,2) < 0
        f(i,2) = -k_wall*yi;    % y-positive force    
    end
end
