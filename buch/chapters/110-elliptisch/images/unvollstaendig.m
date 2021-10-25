#
# unvollstaendig.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global N;
N = 200;
global n;
n = 5;

function retval = integrand_f(t, k)
	retval = 1 / sqrt((1 - t^2) * (1 - k^2 * t^2));
endfunction

function retval = integrand_e(t, k)
	retval = sqrt((1-k^2*t^2)/(1-t^2));
endfunction

function retval = integrand_pi(n, t, k)
	retval = 1 / ((1-n*t^2) * sqrt((1-k^2*t^2)*(1-t^2)));
endfunction

function retval = elliptisch1(f, name, k)
	global N;
	global n;
	s = 0;
	fprintf(f, "\\def\\ell%s{ (0,0)", name);
	delta = 1 / N;
	for x = (0:delta:(1-delta))
		h = delta / n;
		for t = (x+h/2:h:x+delta)
			s = s + integrand_f(t, k) * h;
		endfor
		fprintf(f, "\n    -- ({\\dx*%.4f},{\\dy*%.4f})", x + delta, s);
	endfor
	fprintf(f, "}\n");
endfunction

function retval = elliptisch2(f, name, k)
	global N;
	global n;
	s = 0;
	fprintf(f, "\\def\\ell%s{ (0,0)", name);
	delta = 1 / N;
	for x = (0:delta:(1-delta))
		h = delta / n;
		for t = (x+h/2:h:x+delta)
			s = s + integrand_e(t, k) * h;
		endfor
		fprintf(f, "\n    -- ({\\dx*%.4f},{\\dy*%.4f})", x + delta, s);
	endfor
	fprintf(f, "\n}\n");
endfunction

fn = fopen("unvollpath.tex", "w");

elliptisch1(fn, "Fzero", 0.0);
elliptisch1(fn, "Fone", 0.1);
elliptisch1(fn, "Ftwo", 0.2);
elliptisch1(fn, "Fthree", 0.3);
elliptisch1(fn, "Ffour", 0.4);
elliptisch1(fn, "Ffive", 0.5);
elliptisch1(fn, "Fsix", 0.6);
elliptisch1(fn, "Fseven", 0.7);
elliptisch1(fn, "Feight", 0.8);
elliptisch1(fn, "Fnine", 0.9);
elliptisch1(fn, "Ften", 1.0);

elliptisch2(fn, "Ezero", 0.0);
elliptisch2(fn, "Eone", 0.1);
elliptisch2(fn, "Etwo", 0.2);
elliptisch2(fn, "Ethree", 0.3);
elliptisch2(fn, "Efour", 0.4);
elliptisch2(fn, "Efive", 0.5);
elliptisch2(fn, "Esix", 0.6);
elliptisch2(fn, "Eseven", 0.7);
elliptisch2(fn, "Eeight", 0.8);
elliptisch2(fn, "Enine", 0.9);
elliptisch2(fn, "Eten", 1.0);

fclose(fn);
