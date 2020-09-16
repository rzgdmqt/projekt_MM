function [p, t, v, out] = odboj(X, p0, v0, prozno)
% odboj(X, p0, v0) nam izračuna kje se je odboj zgodil, kdaj se je zgodil,
% s kakšno hitrostjo se je zgodil in ali je žogica zapustila verižnico
% vhodni podatki:
% X ... 2x(n+1) matrika, kjer so v prvi vrstici x in v drugi vrstici y 
% koordinate diskretne verižnice
% p0 ... vektor začetne pozicije kroglice
% v0 ... vektor začetne hitrosti kroglice
% prozno ... če želimo prožne odboje damo na true, sicer na false
% izhodni podati:
% p ... položaj, kje se je odboj zgodil
% t ... čas, kdaj se je odboj zgodil
% v ... hitrost s kakšno se kroglica odbije
% out ... stikalo, ki pove, ali je kroglica zaustila verižnico

% nastavimo začetne vrednosti
g = 9.81;
n = length(X) - 1;
p = NaN;
t = NaN;
v = NaN;
out = false;

% za manj pisarije določimo krajše oznake
x0 = p0(1);
y0 = p0(2);
vx = v0(1);
vy = v0(2);

% poiščemo členek, na katerem se zgodi odboj
for i = 1:n
    % določimo začetno (Z) in končno (K) točko členka verižnice, na katerem
    % se nahajamo
    Z = X(:, i);
    K = X(:, i+1);
    
    % določimo smerni koeficient in začetno vrednost premice, ki določa
    % členek
    k = (Z(2) - K(2)) / (Z(1) - K(1));
    n = Z(2) - k * Z(1);

    % naš vektor položaja P(t) = (x0 + vx*t, y0 + vy*t + gt²/2) vstavimo v
    % enačbo y = kx + n, da dobimo kvadratno enačbo za t in določimo a, b, 
    % c in diskriminanto D
    b = k * vx - vy;
    a = g / 2;
    c = n - y0 + k * x0;
    D = b ^2 - 4 * a * c;
    
    % preverimo, da ne bomo slučajno korenili negativnih vrednosti (se 
    % sploh ne sekata parabola in premica)
    if D < 0
        continue;
    end
    
    % določimo obe presečišči
    t1 = (-b + sqrt(D)) / (2 * a);
    t2 = (-b - sqrt(D)) / (2 * a);
    
    % vzamemo kasnejše, saj je eno v preteklosti, razen v primeru, ko bi
    % verižnico zadeli iz zunanje strani (takih primerov ne obravnavamo)
    t1 = max([t1 t2]);
    
    % čas mora biti pozitiven
    if t1 < 0
        continue;
    end

    % poračunamo točko odboja
    x = vx * t1 + x0;  % enakomerno gibanje v x smeri
    y = k * x + n;  % točka leži na nosilki členka
   
    % če x leži na tej palici smo našli odboj in nastavimo izhodne
    % parametre
    if x >= Z(1) && x <= K(1)
        t = t1;  % čas
        p = [x; y];  % položaj
        T = K - Z;  % smerni vektor členka
        N = [-T(2); T(1)] ./ norm(T); % enotska normala na členek, čez 
        % katero bomo zrcalili
        v = [vx; -g * t + vy];  % vhodna hitrost
        v = v - 2 .* dot(N, v) .* N;  % izhodna hitrost
        % Če želimo, da se energija izgublja, lahko vektor v pomnožimo z
        % nekim faktorjem in je stvar malo bolj realna (naslednja vrstica)
        if ~prozno 
           v = 0.98 * v;
        end
        break;
    end
end

% če položaja nismo našli, je žogico odneslo iz verižnice
if isnan(p)
    out = true;
    t = t1;  % čas nastavimo, saj bomo to želeli narisati
end


end