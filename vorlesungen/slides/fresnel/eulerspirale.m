#
# eulerspirale.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschlue
#
global n;
n = 1000;
global tmax;
tmax = 10;
global N;
N = round(n*5/tmax);

function retval = f(x, t)
	x = pi * t^2 / 2;
	retval = [ cos(x); sin(x) ];
endfunction

x0 = [ 0; 0 ];
t = tmax * (0:n) / n;

c = lsode(@f, x0, t);

fn = fopen("eulerpath.tex", "w");

fprintf(fn, "\\def\\fresnela{ (0,0)");
for i = (2:n)
	fprintf(fn, "\n\t-- (%.4f,%.4f)", c(i,1), c(i,2));
end
fprintf(fn, "\n}\n\n");

fprintf(fn, "\\def\\fresnelb{ (0,0)");
for i = (2:n)
	fprintf(fn, "\n\t-- (%.4f,%.4f)", -c(i,1), -c(i,2));
end
fprintf(fn, "\n}\n\n");

fprintf(fn, "\\def\\Cplotright{ (0,0)");
for i = (2:N)
	fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})", t(i), c(i,1));
end
fprintf(fn, "\n}\n\n");

fprintf(fn, "\\def\\Cplotleft{ (0,0)");
for i = (2:N)
	fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})", -t(i), -c(i,1));
end
fprintf(fn, "\n}\n\n");

fprintf(fn, "\\def\\Splotright{ (0,0)");
for i = (2:N)
	fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})", t(i), c(i,2));
end
fprintf(fn, "\n}\n\n");

fprintf(fn, "\\def\\Splotleft{ (0,0)");
for i = (2:N)
	fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})", -t(i), -c(i,2));
end
fprintf(fn, "\n}\n\n");

fclose(fn);
