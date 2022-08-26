function c_d = drag_coeff(v, d, nu)
Re = abs(v)*d/nu;
if v == 0
    c_d = 0;
elseif Re <= 1
    c_d = 24/Re;
elseif Re > 1 && Re <= 400
    c_d = 24/(Re^0.646);
elseif Re > 400 && Re <= 3e+5
    c_d = 0.5;
elseif Re > 3e+5 && Re <= 2e+6
    c_d = 0.000366*Re^0.4275;
elseif Re > 3e+5
    c_d = 0.18;
end

