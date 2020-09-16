function risi_veriznica(X)
% risi_veriznica(X) nariše diskretno verižnico.
% vhodni parametri:
% X ... 2x(n+1) matrika, kjer so v prvi vrstici x in v drugi vrstici y 
% koordinate diskretne verižnice

% določimo x in y koordinate
x = X(1, :);
y = X(2, :);


hold on
% narišemo palice
plot(x, y, "color", "#0E1BC9", "linewidth", 3);
% označimo spoje
scatter(x, y, "red", "fill");

end