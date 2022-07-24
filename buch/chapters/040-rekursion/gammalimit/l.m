#
# l.m -- Berechnung der Gamma-Funktion
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global N;
N = 10000;

function retval = gamma(x, n)
	p = 1;
	for k = (1:n)
		p = p * k / (x + k - 1);
	end
	retval = p * n^(x-1);
endfunction

for n = (100:100:N)
	printf("Gamma(%4d) = %10f\n", n, gamma(0.5, n));
end
