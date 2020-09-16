function X = dis_ver(u0,zac,L,M)
% dis_ver(u0, zac, L, M) izračuna koordinate krajišč vseh palic pri 
% simetrični diskretni verižnici s sodo mnogo členi.
% vhodni podatki:
% u0 ... začetni približek za reševanje enačbe U(u) = 0
% zac ... matrika obesišč verižnice (levo obesišče je prvi stolpec, 
% desno obesišče je drugi stolpec)
% L ... je vrstica dolžin palic, zaradi simetrije podamo le polovico dolžin
% M ... je vrstica mas palic, zaradi simetrije podamo le polovico mas
% izhodni podatki:
% X ... matrika velikosti 2x(n+1), kjer se v prvi vrstici nahajajo x 
% koordinate palic, v drugi vrsti pa y koordinate palic


p = length(L);
L = [L(1:end) flip(L)];
M = [M(1:end) flip(M)];

mi = (M(1:end-1) + M(2:end)) ./ 2;
vsote_mi = [0 cumsum(mi)];

U = @(u) enacba_u(u, zac, L, vsote_mi, mi);

u = fzero(U, u0);

tmp = u .* (vsote_mi(p) + 0.5 .* mi(p) - vsote_mi);
ksi = L ./ sqrt(1 + tmp.^2);
eta = ksi .* tmp;


x = [zac(1, 1), zac(1, 1) + cumsum(ksi)];
y = [zac(2, 1), zac(2, 1) + cumsum(eta)];

X = [x; y];
    
end


