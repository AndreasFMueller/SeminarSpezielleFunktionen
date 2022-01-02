#
# fibonacci.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global phi1;
phi1 = (1+sqrt(5)) / 2;
phi2 = (1-sqrt(5)) / 2;
global logphi1;
logphi1 = log(phi1)
global logphi2;
logphi2 = log(phi2)

global s;
s = 0.1;

A = [ 1, 1; phi1, phi2 ];
b = [ 0; 1 ];
global a;
a = A \ b

global xmin;
xmin = 0;
global xmax;
xmax = 10;
global ylim;
ylim = 10;

global N;
N = 200;

function retval = fibonacci(n) 
	global a;
	global logphi1;
	global logphi2;
	retval = a(1,1) * exp(n * logphi1) + a(2,1) * exp(n * logphi2);
endfunction

for n = (0:10)
	fibonacci(n)
endfor

function punkt(fn, z)
	if (abs(z) > 100)
		z = 100 * z / abs(z);
	endif
	fprintf(fn, "(%.5f,%.5f)", real(z), imag(z));
endfunction

function drawline(fn, p, color,lw)
	global N;
	fprintf(fn, "\\draw[color=%s,line width=%.1fpt] ", color, lw);
	punkt(fn, p(1));
	for i = (2:N+1)
		fprintf(fn, "\n\t--");
		punkt(fn, p(i));
	endfor
	fprintf(fn, ";\n");
endfunction

function realline(fn, x, ymin, ymax, color, lw)
	global N;
	h = (ymax - ymin) / N;
	fprintf(fn, "%% real line for x = %f, h = %f\n", x, h);
	count = 1;
	for y = ymin + (0:N) * h
		z(count) = fibonacci(x + i * y);
		count = count + 1;
	endfor
	drawline(fn, z, color, lw);
endfunction

function imaginaryline(fn, y, xmin, xmax, color, lw)
	global N;
	h = (xmax - xmin) / N;
	fprintf(fn, "%% imaginary line for y = %f, h = %f\n", y, h);
	count = 1;
	for x = xmin + (0:N) * h
		z(count) = fibonacci(x + i * y);
		count = count + 1;
	endfor
	drawline(fn, z, color, lw);
endfunction

function fibmapping(fn, n, name, lw)
	global s;
	fprintf(fn, "\\def\\%s{\n", name);
	for x = n + s*(-5:5) 
		realline(fn, x, -5*s, 5*s, "red", lw);
	endfor
	for y = s*(-5:5)
		imaginaryline(fn, y, n-5*s, n+5*s, "blue", lw);
	endfor
	fprintf(fn, "}\n");
endfunction

function fibgrid(fn, lw)
	global s;
	fprintf(fn, "\\def\\fibgrid{\n");
	for y = s*(-5:5)
		imaginaryline(fn, y, -0.5, 6.5, "gray", lw);
	endfor
	for x = s*(-5:65)
		realline(fn, x, -0.5, 0.5, "gray", lw);
	endfor
	fprintf(fn, "}\n");
endfunction

function fibcurve(fn, lw)
	fprintf(fn, "\\def\\fibcurve{\n");
	imaginaryline(fn, 0, 0, 6.5, "white", 1.2*lw);
	imaginaryline(fn, 0, 0, 6.5, "darkgreen", lw);
	for n = (0:6)
		z = fibonacci(n);
		fprintf(fn, "\\fill[color=darkgreen] ");
		punkt(fn, z);
		fprintf(fn, " circle[radius=0.08];\n");
		fprintf(fn, "\\fill[color=white] ");
		punkt(fn, z);
		fprintf(fn, " circle[radius=0.04];\n");
	endfor
	fprintf(fn, "}\n");
endfunction

fn = fopen("fibonaccigrid.tex", "w");
fibmapping(fn, 0, "fibzero", 1);
fibmapping(fn, 1, "fibone", 1);
fibmapping(fn, 2, "fibtwo", 1);
fibmapping(fn, 3, "fibthree", 1);
fibmapping(fn, 4, "fibfour", 1);
fibmapping(fn, 5, "fibfive", 1);
fibmapping(fn, 6, "fibsix", 1);
fibgrid(fn, 0.3);
fibcurve(fn, 1.4);

fclose(fn);
