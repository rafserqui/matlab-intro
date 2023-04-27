function F = system_focs(x,a)
    k = x(1);
    l = x(2);

    F(1) = a(1) - 2 .* a(3) .* k + 2 .* a(4) .* l;
    F(2) = a(2) + a(4) .* k - 3.*a(5).*l.^2;
end