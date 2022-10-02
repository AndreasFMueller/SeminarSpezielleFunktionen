#
# gammadgl.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global z;
z = 5/3;
global counter;
counter = 0;

function retval = integrand(x, t)
	global z;
	global counter;
	counter = counter + 1;
	retval = (t ^ (z-1)) * exp(-t);
endfunction

t = [0,1,10,100,1000,10000,100000,1000000];

format long

r = lsode(@integrand, 0, t)
counter

g = gamma(z)

for k = (1:6)
	printf("%d & %.10f & %.10f \\\\\n", k, r(k,1), r(k,1) - g);
endfor

