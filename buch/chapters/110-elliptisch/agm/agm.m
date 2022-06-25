#
# agm.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
format long

n = 10;
a = 1;
b = sqrt(0.5);

for i = (1:n)
	printf("%20.16f %20.16f\n", a, b);
	A = (a+b)/2;
	b = sqrt(a*b);
	a = A;
end	

K = pi / (2 * a)

