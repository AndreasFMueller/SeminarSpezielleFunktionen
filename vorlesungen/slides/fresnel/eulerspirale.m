#
# eulerspirale.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschlue
#
global n;
n = 10000;
global tmax;
tmax = 10;

function retval = f(x, t)
	retval = [ cos(t*t); sin(t*t) ];
endfunction

x0 = [ 0; 0 ];
t = tmax * (0:n) / n;

c = lsode(@f, x0, t);

fn = fopen("eulerpath.tex", "w");

fprintf(fn, "\\def\\fresnela{ (0,0)");
for i = (2:n)
	fprintf(fn, "\n\t-- (%.4f,%.4f)", c(i,1), c(i,2));
end
fprintf(fn, "\n}\n");

fprintf(fn, "\\def\\fresnelb{ (0,0)");
for i = (2:n)
	fprintf(fn, "\n\t-- (%.4f,%.4f)", -c(i,1), -c(i,2));
end
fprintf(fn, "\n}\n");

fclose(fn);
