function U = enacba_u(u,zac,L,vsote_mi, mi)
% enacba_u(u, zac, L, vsote_mi, mi) vrne funkcijo U, ki je odvisna od 
% vhodnega parametra u.
% vhodni podatki:
% u ... parameter, od katerega je odvisna izhodna funkcija
% zac ... matrika obesišč verižnice (levo obesišče je prvi stolpec, 
% desno obesišče je drugi stolpec)
% L ... matrika dolžin VSEH palic
% M ... matrika mas VSEH palic
% vsote_mi ... vrstica komulativnih vsot povprečij mas sosednjih palic
% mi ... movprečja mas sosednjih palic
% izhodni podatki:
% U ... funkcija odvisna od parametra u

n = length(L);
p = n / 2;

ksi = L ./ sqrt(1 + (u .* (vsote_mi(p) + 0.5 .* mi(p) - vsote_mi)).^2);

U = sum(ksi) - zac(1, 2) + zac(1, 1);


end