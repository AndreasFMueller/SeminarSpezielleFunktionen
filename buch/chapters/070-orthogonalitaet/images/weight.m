#
# weight.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global N;
N = 200;
global s;
s = 8;
global l;
l = 10;
global A;
A = 0.3;

function retval = gewicht(x)
	global	s;
	retval = (x + 1)^(-2) * (x + 1/3)^(-0.9) * (x - 1/3) * (x - 1)^2 * exp(s * x);
endfunction

h = 2 / N;
x = (-1:h:1);

function punkt(fn, x, y)
	global A;
	fprintf(fn, "(%.4f,%.4f)", x, A * abs(y));
endfunction

fn = fopen("weightfunction.tex", "w");
plotting = 0;
drittelsuchen = 1;
for i = (1:N+1)
	if (drittelsuchen > 0)
		if (x(i) > (1/3))
			fprintf(fn, "\n\t-- ");
			punkt(fn, 1/3, 0);
			fprintf(fn, "% drittel");
			drittelsuchen = 0
		end
	end
	y = gewicht(x(i));
	if (plotting > 0) 
		if (abs(y) > l)
			fprintf(fn, ";\n");
			plotting = 0;
		end
		fprintf(fn, "\t\n-- ");
		punkt(fn, x(i), y);
	else
		if (abs(y) < l)
			fprintf(fn, "\\draw[color=red,line width=2.0pt] ");
			punkt(fn, x(i), y);
			plotting = 1;
		end
	end
endfor
if (plotting > 0)
	fprintf(fn, ";\n");
end
fclose(fn);
