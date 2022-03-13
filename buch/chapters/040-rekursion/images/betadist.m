#
# betadist.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global N;
N = 201;
global nmin;
global nmax;
nmin = -4;
nmax = 7;
n = nmax - nmin + 1
A = 3;

t = (nmin:nmax) / nmax;
alpha = 1 + A * t .* abs(t)
#alpha(1) = 0.01;

#alpha = [ 1, 1.03, 1.05, 1.1, 1.25, 1.5, 2, 2.5, 3, 4, 5 ];
beta = alpha;
names = [ "one"; "two"; "three"; "four"; "five"; "six"; "seven"; "eight";
	  "nine"; "ten"; "eleven"; "twelve" ]

function retval = Beta(a, b, x)
	retval = x^(a-1) * (1-x)^(b-1) / beta(a, b);
	if (retval > 100)
		retval = 100
	end
end

function plotbeta(fn, a, b, name)
	global N;
	fprintf(fn, "\\def\\beta%s{\n", strtrim(name));
	fprintf(fn, "\t({%.4f*\\dx},{%.4f*\\dy})", 0, Beta(a, b, 0));
	for x = (1:N-1)/(N-1)
		X = (1-cos(pi * x))/2;
		fprintf(fn, "\n\t--({%.4f*\\dx},{%.4f*\\dy})",
			X, Beta(a, b, X));
	end
	fprintf(fn, "\n}\n");
end

fn = fopen("betapaths.tex", "w");

for i = (1:n)
	fprintf(fn, "\\def\\alpha%s{%f}\n", strtrim(names(i,:)), alpha(i));
	fprintf(fn, "\\def\\beta%s{%f}\n", strtrim(names(i,:)), beta(i));
end

for i = (1:n)
	for j = (1:n)
		printf("working on %d,%d:\n", i, j);
		plotbeta(fn, alpha(i), beta(j),
			char(['a' + i - 1, 'a' + j - 1]));
	end
end

fclose(fn);
