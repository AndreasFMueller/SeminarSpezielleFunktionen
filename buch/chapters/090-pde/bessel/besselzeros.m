#
# besselzeros.m -- find zeros of bessel functions
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
# 
global maxmu;
maxmu = 7;
global maxk;
maxk = 10;
global mu;

nachkommastellen = 4;

function retval = f(x)
	global mu;
	retval = besselj(mu, x);
endfunction

kzeros = zeros(maxk+1, maxmu+1);
for mu = (0:maxmu)
	k = 0;
	if (mu > 0)
		kzeros(1, mu+1) = 0;
		k = k+1;
	endif
	x = 0.0001;
	while (k <= maxk)
		bracket = [ x, x+1 ];
		if (f(bracket(1)) * f(bracket(2)) < 0) 
			kzeros(k+1,mu+1) = fzero("f", bracket);
			k = k + 1;
		endif
		x = x + 1;
	endwhile
endfor

# kzeros

fn = fopen("besselzeros.tex", "w");

fprintf(fn, "\\begin{tabular}{|>{$}c<{$}");
for mu = (0:maxmu)
	fprintf(fn, "|>{$}r<{$}");
endfor
fprintf(fn, "|}\n");

fprintf(fn, "\\hline\n");
fprintf(fn, " k ");
for mu = (0:maxmu)
	fprintf(fn, "& \\mu = %d ", mu);
endfor
fprintf(fn, "\\\\\n");
fprintf(fn, "\\hline\n");

for k = (0:maxk)
	fprintf(fn, " %d ", k);
	for mu = (0:maxmu)
		value = kzeros(k+1, mu+1);
		if (value == 0) 
			fprintf(fn, "& 0\\phantom{.%0*d}", nachkommastellen, 0);
		else
			fprintf(fn, "& %*.*f", nachkommastellen+4, nachkommastellen, kzeros(k+1, mu+1));
		endif
	endfor
	fprintf(fn, "\\\\\n");
endfor
fprintf(fn, "\\hline\n");
fprintf(fn, "\\end{tabular}\n");

fclose(fn);
