#
# laguerre.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
pkg load miscellaneous
global N;
N = 120;

function retval = laguerre(n, x)
	s = 1;
	p = 1;
	if (n == 0)
		retval = p;
	else
		for k = (1:n)
			p = p * x * (-n-1+k) / (k * k);
			s = s + p;
		endfor
		retval = s;
	end
endfunction

function retval = laguerrepath(fn, n, name)
	global N;
	h = 12 / N;
	fprintf(fn, "\\def\\laguerre%s{\n", name)
	fprintf(fn, "\t   ({%.5f*\\dx},{%.5f*\\dy})", 0, 1);
	for i = (1:N)
		x = h * i;
		y = laguerre(n, x);
		if (abs(y) > 100)
			y = 100 * sign(y);
		end
		fprintf(fn, "\n\t-- ({%.5f*\\dx},{%.5f*\\dy})", x, y);
	endfor
	fprintf(fn, "\n}\n");
endfunction

fn = fopen("laguerrepaths.tex", "w");

laguerrepath(fn,  0, "zero");
laguerrepath(fn,  1, "one");
laguerrepath(fn,  2, "two");
laguerrepath(fn,  3, "three");
laguerrepath(fn,  4, "four");
laguerrepath(fn,  5, "five");
laguerrepath(fn,  6, "six");
laguerrepath(fn,  7, "seven");
laguerrepath(fn,  8, "eight");
laguerrepath(fn,  9, "nine");

fclose(fn);


