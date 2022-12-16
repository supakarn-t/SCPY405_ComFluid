function X = sphCircle(c0, r, n, h)
X = zeros(n, 2);
i = 1;
distance = r*rand;
angle = 360*rand;
x = c0(1) + distance*cosd(angle);
y = c0(2) + distance*sind(angle);
X(1, :) = [x, y];

while 1
    distance = r*rand;
    angle = 360*rand;
    x = c0(1) + distance*cosd(angle);
    y = c0(2) + distance*sind(angle);
    fail = 0;
    for j = 1:i
        dx = x-X(j,1);
        dy = y-X(j,2);
        distance = sqrt(dx*dx+dy*dy);
        if distance < h
            fail = 1;
            break;
        end
    end
    if fail
        continue;
    end
    i = i+1;
    if i > n
        break;
    end
    X(i, :) = [x, y];
end

end

