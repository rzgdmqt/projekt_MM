function animacija(T, P, V)
% animacija(T, P, V) animira skakanje kroglice po verižnici
% vhodni podatki:
% T ... vrstica časov odbojev
% P ... 2x(n+1) matrika položajev odbojev
% V ... 2x(n+1) matrika izhodnih hitrosti odbojev

g = 9.81;
for i=1:length(T)-1
    d = sqrt(T(i + 1)) * 70;
    tt = linspace(0, T(i + 1), d);
    x = @(t) V(1, i)*t + P(1, i);
    y = @(t) V(2, i)*t + P(2, i) - (g * t .^2 / 2);
    hold on;
    for j=1:d
        xj = x(tt(j));
        yj = y(tt(j));
        a = scatter(xj, yj, 100, [1,0,1], "o", "fill");
        % Naslednjo vrstico se odkomentira, če se želi videti sled žoge.
        % (zelo opočasni animacijo)
        % b = scatter(xj, yj, 5, [1,0,1], "o", "fill");
        pause(0.0001);
        delete(a);
    end
    % če še nismo na koncu in do naslednjega odboja ne bo prišlo,
    % končamo
    if i ~= length(T) - 1
        if isnan(T(i + 2))
            break;
        end
    end
end
% narišemo končno pozicijo kroglice
scatter(x(tt(j)), y(tt(j)), 100, [1,0,1], "o", "fill");

end