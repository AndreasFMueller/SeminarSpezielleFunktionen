%
% zetaplot.m
%
% (c) 2022 Prof Dr Andreas Müller
%
s = 1;
h = 0.02;
m = 40;

fn = fopen("zetapath.tex", "w");
fprintf(fn, "\\def\\zetapath{\n");
counter = 0;
for y = (0:h:m)
	if (counter > 0)
		fprintf(fn, "\n\t--");
	end
	z = zeta(0.5 + i*y);
	fprintf(fn, " ({%.4f*\\dx},{%.4f*\\dy})", real(z), imag(z));
	counter = counter + 1;
end
fprintf(fn, "\n}\n");
fclose(fn);

