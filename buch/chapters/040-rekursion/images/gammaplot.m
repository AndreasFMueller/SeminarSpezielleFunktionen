#
# gammaplot.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

fn = fopen("gammapaths.tex", "w");

function finterval(f, fn, from, to, name, delta)
	fprintf(fn, "\\def\\gamma%s{", name);
	x = from + delta;
	fprintf(fn, "({\\dx*%.4f},{\\dy*%.4f})", x, f(x));
	x = from + 0.02;
	for x = (from+0.02:0.02:to-0.02)
		fprintf(fn, "\n -- ");
		fprintf(fn, "({\\dx*%.4f},{\\dy*%.4f})", x, f(x));
	endfor
	x = to - delta;
	fprintf(fn, "\n -- ");
	fprintf(fn, "({\\dx*%.4f},{\\dy*%.4f})", x, f(x));
	fprintf(fn, "}\n");
endfunction

function gammainterval(fn, from, to, name, delta)
	finterval(@gamma, fn, from, to, name, delta)
endfunction

function retval = gammasin(x) 
	retval = gamma(x) + sin(x * pi);
endfunction

function gammasininterval(fn, from, to, name, delta)
	finterval(@gammasin, fn, from, to, name, delta)
endfunction

gammainterval(fn,  0,  4.1, "plus",  0.019);
gammainterval(fn, -1,  0,   "one",   0.019);
gammainterval(fn, -2, -1,   "two",   0.019);
gammainterval(fn, -3, -2,   "three", 0.019);
gammainterval(fn, -4, -3,   "four",  0.005);
gammainterval(fn, -5, -4,   "five",  0.001);
gammainterval(fn, -6, -5,   "six",  0.0002);

gammasininterval(fn,  0,  4.1, "sinplus",  0.019);
gammasininterval(fn, -1,  0,   "sinone",   0.019);
gammasininterval(fn, -2, -1,   "sintwo",   0.019);
gammasininterval(fn, -3, -2,   "sinthree", 0.019);
gammasininterval(fn, -4, -3,   "sinfour",  0.005);
gammasininterval(fn, -5, -4,   "sinfive",  0.001);
gammasininterval(fn, -6, -5,   "sinsix",  0.0002);

fclose(fn);
