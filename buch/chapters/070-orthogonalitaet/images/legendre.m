#
# legendre.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
pkg load miscellaneous
global N;
N = 30;

function retval = legendrepath(fn, n, name)
	global N;
	m = n * N;
	c = legendrepoly(n)
	x = (-m:m)/m;
	v = polyval(c, x);
	fprintf(fn, "\\def\\legendre%s{\n", name)
	fprintf(fn, "\t   ({%.5f*\\dx},{%.5f*\\dy})", x(1), v(1));
	for i = (2:length(v))
		fprintf(fn, "\n\t-- ({%.5f*\\dx},{%.5f*\\dy})", x(i), v(i));
		
	endfor
	fprintf(fn, "\n}\n");
	ci = polyint(conv(c, c))
polyval(ci, 1)
	normalization = sqrt(polyval(ci, 1) - polyval(ci, -1))
	fprintf(fn, "\\def\\normalization%s{%.5f}\n", name, normalization);
endfunction

function retval = legendreprodukt(fn, a, b, name)
	global N;
	n = max(a, b);
	m = n * N;
	pa = legendrepoly(a);
	pb = legendrepoly(b);
	p = conv(pa, pb);
	x = (-m:m)/m;
	v = polyval(p, x);
	fprintf(fn, "\\def\\produkt%s{\n", name)
	fprintf(fn, "\t   ({%.5f*\\dx},{%.5f*\\dy})", x(1), v(1));
	for i = (2:length(v))
		fprintf(fn, "\n\t-- ({%.5f*\\dx},{%.5f*\\dy})", x(i), v(i));
	endfor
	fprintf(fn, "\n}\n");
endfunction

fn = fopen("legendrepaths.tex", "w");
legendrepath(fn,  1, "one");
legendrepath(fn,  2, "two");
legendrepath(fn,  3, "three");
legendrepath(fn,  4, "four");
legendrepath(fn,  5, "five");
legendrepath(fn,  6, "six");
legendrepath(fn,  7, "seven");
legendrepath(fn,  8, "eight");
legendrepath(fn,  9, "nine");
legendrepath(fn, 10, "ten");

legendreprodukt(fn, 4, 7, "ortho");
legendreprodukt(fn, 4, 4, "vier");
legendreprodukt(fn, 7, 7, "sieben");

fclose(fn);


