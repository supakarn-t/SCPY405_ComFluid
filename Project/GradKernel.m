function dW = GradKernel(r,h)
    % 2 dimensions only
    norm_r = sqrt(r(1)^2 + r(2)^2);
	n = -2 * exp( -norm_r^2 / h^2) / (h^4*pi) ;
	dW = n .* r;
end
