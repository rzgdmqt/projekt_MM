% Projekt pri predmetu matematično modeliranje. 
% Naloga 1: Simetrična diskretna verižnica s sodo mnogo členi.
% Imeli bomo 2p homogenih palic.

% obesišči A, B (A(2) == B(2), ker je verižnica simetrična)
A = [0; 0]; % levo obesišče
B = [7; A(2)]; % desno obesišče

u0 = 0;  % začetni približek za reševanje enačbe
zac = [A(1), B(1); A(2), B(2)];  % matrika obesišč verižnice
L = [1,2,1.5,3];  % dolžine prvih p palic
M = [1,5,1,2];  % mase prvih p palic

X = dis_ver(u0,zac,L,M)  % rešimo problem diskretne verižnice

% Naloga 2: Odbijanje kroglice ko prosto pade z začetno hitrostjo v0 
% na prvi členek verižnice.
n = 100;  % število simuliranih odbojev
v0 = [2; 1];  % vektor začetne hitrosti
p0 = [-1; 1];  % vektor začetne lege
prozno = false;  % če želimo prožne odboje je true, sicer false. Če 
% nastavimo na false, risanka traja dlje in je zato bolj zanimivo.
[T, P, V] = odboji(X, p0, v0, n, prozno)  % poračunamo čase, lege in hitrosti za n odbojev



% Grafični prikaz:
% določimo lego okvirja slike
x0=100;
y0=100;
% določimo velikost okvirja
width=1000;
height=800;
% zgornje dejansko nastavimo
set(gcf,'position',[x0,y0,width,height])
% nastavimo si velikost koordinatnega sistema, 
% da se med premikanjem žogice ne spreminja (trenutno je nastavljeno za ta konkreten primer)
axis([-1 8 -7 3])  

% narišemo verižnico
risi_veriznica(X);

% animiramo skakanje žogice (žogico lahko vržemo od kjerkoli, vendar se mora
% prvi odboj zgoditi v notranjosti verižnice, potem pa lahko žogico odnese tudi ven)
% Opomba: klic funkcije animacija ne nariše verižnice, zato je treba
% najprej klicati risi_veriznica, saj veriznica sicer ne bo prikazana
animacija(T, P, V);
% na koncu narišemo celotno trajektorijo gibanja po verižnici
risi_odboje(T, P, V);
