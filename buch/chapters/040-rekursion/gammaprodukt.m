#
# gammaprodukt.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global mascheroni;
mascheroni = 0.5772156649015328606065120;

function retval = Gamma(x, n)
	global mascheroni;
	retval = x * exp(mascheroni * x);
	for faktor = (1:n)
		q = x / faktor;
		s = (1 + q) * exp(-q);
		retval = retval * s;
	endfor
	retval = 1 / retval;
endfunction

format long

Gamma(0.5,1000)
gamma(0.5)

Gamma(0.5,10000) - gamma(0.5)

for k = (1:6)
	n = 10^k;
	g = Gamma(0.5, n);
	printf("%d & %.10f & %.10f \\\\\n", k, g, g - gamma(0.5));
endfor

