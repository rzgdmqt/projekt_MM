function [T, P, V] = odboji(X, p0, v0, n, prozno)
% odboji(X, p0, v0, n) izračuna vse odboje na diskretni verižnici
% vhodni podatki:
% X ... 2x(n+1) matrika, kjer so v prvi vrstici x in v drugi vrstici y 
% koordinate diskretne verižnice
% p0 ... vektor začetne pozicije kroglice
% v0 ... vektor začetne hitrosti kroglice
% n ... število simuliranih odbojev
% prozno ... če želimo prožne odboje damo na true, sicer na false
% izhodni podatki:
% T ... vrstica časov ko se zgodi odboj (vsak odboj posebej narišemo od 0 do ti)
% P ... 2x(n+1) matrika položajev odbojev kroglice
% V ... 2x(n+1) matrika hitrosti kroglic po odboju

% nastavimo začetne matrike
T = NaN(1, n+1);
P = zeros(2, n+1);
V = zeros(2, n+1);

% začetne vrednosti
T(1) = 0;
P(:, 1) = p0;
V(:, 1) = v0;

% računamo odboje
for i = 1:n
    % ugotovimo kje, kdaj, s kakšno hitrostjo se žogica odbije in ali je še
    % znotraj verižnice
    [p0, t, v0, out] = odboj(X, p0, v0, prozno);
    
    % nastavimo vrednosti
    T(i+1) = t;
    P(:, i+1) = p0;
    V(:, i+1) = v0;
    
    % če smo zunaj verižnice, končamo.
    if out
        break;
    end

end

end