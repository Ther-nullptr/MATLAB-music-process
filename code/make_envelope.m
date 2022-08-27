function [y] = make_envelope(x, a, b)
    y = a*x.*exp(-b.*x).*(x>0);
end