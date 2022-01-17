#
# membran.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global n;
n = 3;
global A;
A = 0.2;
global nullstelle;
nullstelle = 13.0152;
global skala;
skala = 1 / nullstelle;
phisteps = 628;
phistep = 2 * pi / phisteps;
rsteps = 200;
rstep = 1 / rsteps;

fn = fopen("membran.inc", "w");
fprintf(fn, "#macro flaeche()\n");

function retval = punkt(fn, phi, r, n)
	global nullstelle;
	global skala;
	global A;
	fprintf(fn, "\n\t    <%.4f, %.4f, %.4f>",
		r * cos(phi),
		A * besselj(n, nullstelle * r) * cos(n * phi),
		r * sin(phi)
	);
endfunction

for i = (0:phisteps)
	phi = i * phistep;
	r = rstep;
	fprintf(fn, "\ttriangle {");
	punkt(fn, 0, 0, n);		fprintf(fn, ",");
	punkt(fn, phi, rstep, n);	fprintf(fn, ",");
	punkt(fn, phi+phistep, rstep, n);
	fprintf(fn, "\n\t}\n");

	for j = (1:rsteps-1)
		r = j * rstep;
		fprintf(fn, "\ttriangle {");
		punkt(fn, phi, r, n);			fprintf(fn, ",");
		punkt(fn,  phi+phistep, r, n);		fprintf(fn, ",");
		punkt(fn, phi+phistep, r+rstep, n);
		fprintf(fn, "\n\t}\n");
		fprintf(fn, "\ttriangle {");
		punkt(fn, phi, r, n);			fprintf(fn, ",");
		punkt(fn, phi+phistep, r+rstep, n);	fprintf(fn, ",");
		punkt(fn, phi, r+rstep, n);
		fprintf(fn, "\n\t}\n");
	end
end

fprintf(fn, "#end\n");

function retval = ring(fn, r, n)
	phisteps = 100;
	phistep = 2 * pi / phisteps;
	for i = (1:phisteps)
		phi = phistep * i;
		fprintf(fn, "\tcylinder {");
		punkt(fn, phi - phistep, r, n);		fprintf(fn, ",");
		punkt(fn, phi, r, n);			fprintf(fn, ",");
		fprintf(fn, "\n\t    r");
		fprintf(fn, "\n\t}\n")
		fprintf(fn, "\tsphere {");
		punkt(fn, phi - phistep, r, n);		fprintf(fn, ",");
		fprintf(fn, "\n\t    r");
		fprintf(fn, "\n\t}\n")
	end
end

function retval = radius(fn, phi, n)
	rsteps = 100;
	rstep = 1 / rsteps;
	for i = (0:rsteps-1)
		r = i * rstep;
		fprintf(fn, "\tcylinder {");
		punkt(fn, phi, r, n);		fprintf(fn, ",");
		punkt(fn, phi, r+rstep, n);	fprintf(fn, ",");
		fprintf(fn, "\n\t    r");
		fprintf(fn, "\n\t}\n")
		fprintf(fn, "\tsphere {");
		punkt(fn, phi, r, n);		fprintf(fn, ",");
		fprintf(fn, "\n\t    r");
		fprintf(fn, "\n\t}\n")
	end
end

fprintf(fn, "#macro phigitter()\n");
rsteps = 20;
rstep = 1 / rsteps;
for j = (1:rsteps-1)
	ring(fn, rstep * j, n);
end
fprintf(fn, "#end\n");

fprintf(fn, "#macro rgitter()\n");
phisteps = 72;
phistep = 2 * pi / phisteps;
for i = (0:phisteps-1)
	radius(fn, phistep * i, n);
end
fprintf(fn, "#end\n");

fclose(fn);
