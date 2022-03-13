#
# order.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global N;
N = 10;
global subdivisions;
subdivisions = 100;
global P;
P = 0.5

function retval = orderF(p, n, k)
	retval = 0;
	for i = (k:n)
		retval = retval + nchoosek(n,i) * p^i * (1-p)^(n-i);
	end
end

function retval = orderd(p, n, k)
	retval = 0;
	for i = (k:n)
		s = i * p^(i-1) * (1-p)^(n-i);
		s = s - p^i * (n-i) * (1-p)^(n-i-1);
		retval = retval + nchoosek(n,i) * s;
	end
end

function retval = orders(p, n, k)
	retval = k * nchoosek(n, k) * p^(k-1) * (1-p)^(n-k);
end

function orderpath(fn, k, name)
	fprintf(fn, "\\def\\order%s{\n\t(0,0)", name);
	global N;
	global subdivisions;
	for i = (0:subdivisions)
		p = i/subdivisions;
		fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})",
			p, orderF(p, N, k));
	end
	fprintf(fn, "\n}\n");
end

function orderdpath(fn, k, name)
	fprintf(fn, "\\def\\orderd%s{\n\t(0,0)", name);
	global N;
	global subdivisions;
	for i = (1:subdivisions-1)
		p = i/subdivisions;
		fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})",
			p, orderd(p, N, k));
	end
	fprintf(fn, "\n\t-- ({1*\\dx},0)");
	fprintf(fn, "\n}\n");
end

function orderspath(fn, k, name)
	fprintf(fn, "\\def\\orders%s{\n\t(0,0)", name);
	global N;
	global subdivisions;
	for i = (1:subdivisions-1)
		p = i/subdivisions;
		fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})",
			p, orders(p, N, k));
	end
	fprintf(fn, "\n\t-- ({1*\\dx},0)");
	fprintf(fn, "\n}\n");
end

fn = fopen("orderpath.tex", "w");

orderpath(fn,   0, "zero");
orderdpath(fn,  0, "zero");
orderspath(fn,  0, "zero");

orderpath(fn,   1, "one");
orderdpath(fn,  1, "one");
orderspath(fn,  1, "one");

orderpath(fn,   2, "two");
orderdpath(fn,  2, "two");
orderspath(fn,  2, "two");

orderpath(fn,   3, "three");
orderdpath(fn,  3, "three");
orderspath(fn,  3, "three");

orderpath(fn,   4, "four");
orderdpath(fn,  4, "four");
orderspath(fn,  4, "four");

orderpath(fn,   5, "five");
orderdpath(fn,  5, "five");
orderspath(fn,  5, "five");

orderpath(fn,   6, "six");
orderdpath(fn,  6, "six");
orderspath(fn,  6, "six");

orderpath(fn,   7, "seven");
orderdpath(fn,  7, "seven");
orderspath(fn,  7, "seven");

orderpath(fn,   8, "eight");
orderdpath(fn,  8, "eight");
orderspath(fn,  8, "eight");

orderpath(fn,   9, "nine");
orderdpath(fn,  9, "nine");
orderspath(fn,  9, "nine");

orderpath(fn,  10, "ten");
orderdpath(fn, 10, "ten");
orderspath(fn, 10, "ten");

fclose(fn);


