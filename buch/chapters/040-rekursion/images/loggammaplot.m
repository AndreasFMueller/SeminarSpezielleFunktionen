#
# loggammaplot.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
xmax = 10;
xmin = 0.1;
N = 500;

fn = fopen("loggammadata.tex", "w");

fprintf(fn, "\\def\\loggammapath{\n ({%.4f*\\dx},{%.4f*\\dy})",
	xmax, log(gamma(xmax)));
xstep = (xmax - 1) / N;
for x = (xmax:-xstep:1)
	fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})", x, log(gamma(x)));
endfor
for k = (0:0.2:10)
	x = exp(-k);
	fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})", x, log(gamma(x)));
endfor
fprintf(fn, "\n}\n");

function retval = lgp(fn, x0, name)
	fprintf(fn, "\\def\\loggammaplot%s{\n", name);
	fprintf(fn, "\\draw[color=red,line width=1pt] ");
	for k = (-7:0.1:7)
		x = x0 + 0.5 * tanh(k);
		if (k > -5)
			fprintf(fn, "\n\t-- ");
		end
		fprintf(fn, "({%.4f*\\dx},{%.4f*\\dy})", x, log(gamma(x)));
	endfor
	fprintf(fn, ";\n}\n");
endfunction

lgp(fn, -0.5, "zero");
lgp(fn, -1.5, "one");
lgp(fn, -2.5, "two");
lgp(fn, -3.5, "three");
lgp(fn, -4.5, "four");

fclose(fn);
