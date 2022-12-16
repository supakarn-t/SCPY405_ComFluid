%  rect = [xmin, ymin, width, height]
function r = sphSquare(rect, h)
xmin = rect(1);
ymin = rect(2);
width = rect(3);
height = rect(4);

x = xmin:h:xmin+width;
y = ymin:h:ymin+height;
[X, Y] = meshgrid(x, y);
r = [X(:), Y(:)];
end

