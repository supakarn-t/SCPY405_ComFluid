function f = CalContactForce(x, k_wall)

N = size(x,1);
f = zeros(N,2);

for i = 1 : N
    xi = x(i,1);
    yi = x(i,2);
    
% The walls are located at x<0, x>1, and y<0
    if xi < 0
        f(i,1) = -k_wall*xi;    % x-positive force
    elseif xi > 1
        f(i,1) = k_wall*(1-xi); % x-negative force
    end
    if yi < 0
        f(i,2) = -k_wall*yi;    % y-positive force    
    end
    if yi > 1
        f(i,2) = k_wall*(1-yi);    % y-negative force    
    end

% Right of tanks are located at x>0.4, x<0.44, y>0.64, y<1
    if xi > 0.4 && xi < 0.41 && yi > 0.64 && yi < 1 % <<
        f(i,1) = -k_wall*abs(xi-0.4); 
    end
    if xi > 0.43 && xi < 0.44 && yi > 0.64 && yi < 1 % >>
        f(i,1) = k_wall*abs(0.44-xi); 
    end
    if xi > 0.4 && xi < 0.44 &&  yi > 0.64 && yi < 0.65 % VV
        f(i,2) = -k_wall*abs(0.64-yi); 
    end

% Bottom of tanks are located at x>0.01, x<0.44, y>0.6, y<0.56
    if xi > 0 && xi < 0.44 &&  yi > 0.59 && yi < 0.6 % AA
%         f(i,1) = k_wall*abs(0.04-xi);
        f(i,2) = k_wall*abs(yi-0.6);
    end
    if xi > 0 && xi < 0.44 &&  yi > 0.56 && yi < 0.57 % VV
        f(i,2) = -k_wall*abs(0.56-yi); 
    end
    if xi > 0.43 && xi < 0.44 && yi > 0.56 && yi < 0.6 % >>
        f(i,1) = k_wall*abs(0.44-xi); 
    end

% plot([.43,.02,.02,.04,.04,.43,.43],[.59,.59,.02,.02,.57,.57,.59],'k');
% Pipe are located at x>0.01, x<0.05, y>0.01, y<0.6
    if xi > 0 && xi < 0.03 && yi > 0.01 && yi < 0.6 % << but AA
        f(i,1) = -k_wall*abs(xi);
        if yi > 0 && yi < 0.1
            f(i,2) = k_wall*abs(yi-0.05);
        elseif yi > 0.1 && yi < 0.2
            f(i,2) = k_wall*abs(yi-0.15);
        elseif yi > 0.2 && yi < 0.3
            f(i,2) = k_wall*abs(yi-0.25);
        elseif yi > 0.3 && yi < 0.4
            f(i,2) = k_wall*abs(yi-0.35);
        elseif yi > 0.4 && yi < 0.5
            f(i,2) = k_wall*abs(yi-0.45);
        elseif yi > 0.5 && yi < 0.55
            f(i,2) = k_wall*abs(yi-0.55);
        elseif yi > 0.55 && yi < 0.6
            f(i,2) = k_wall*abs(yi-0.6);
        end
    end
    if xi > 0.03 && xi < 0.05 && yi > 0.01 && yi < 0.6 % >>
        f(i,1) = k_wall*abs(0.05-xi); 
    end
    if xi > 0.005 && xi < 0.05 &&  yi > 0.01 && yi < 0.02 % VV
        f(i,2) = -k_wall*abs(0.01-yi); 
    end
end
