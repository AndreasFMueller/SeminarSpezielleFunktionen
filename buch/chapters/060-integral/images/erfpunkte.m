#
# erf.m provide plot data for error function
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
N = 93;
x = (-N:N) / 30;
y = erf(x);

fn = fopen("erfpunkte.tex", "w");
fprintf(fn, "\\def\\erfpfad{(%.3f,%.3f)", x(1), y(1));
for i = (2:(2*N+1)) 
	fprintf(fn, "\n -- (%.3f,%.3f)", x(i), y(i));
endfor
fprintf(fn, "}\n");
fclose(fn)
