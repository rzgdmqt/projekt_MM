function risi_odboje(T, P, V)
% risi_odboje(T, P, V) nariše celotno trajektorijo kroglice
% vhodni podatki:
% T ... vrstica časov odbojev
% P ... 2x(n+1) matrika položajev odbojev
% V ... 2x(n+1) matrika izhodnih hitrosti odbojev

g = 9.81;
for i=1:length(T)-1
    tt = linspace(0, T(i + 1));
    % funkciji določata gibanje koordinat kroglice
    x = @(t) V(1, i)*t + P(1, i);
    y = @(t) V(2, i)*t + P(2, i) - (g * t .^2 / 2);
    hold on;
    plot(x(tt), y(tt), "m");
end

end