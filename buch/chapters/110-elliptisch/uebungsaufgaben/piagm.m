#
# piagm.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
N = 20;

a0 = 1;
b0 = sqrt(2)/2;

format long

a = zeros(N, 2);
a(1,1) = a0;
a(1,2) = b0;
for n = (1:N-1)
	a(n+1,1) = (a(n,1) + a(n,2))/2;
	a(n+1,2) = sqrt(a(n,1)*a(n,2));
end
a
agm = a(N,1);


s = 0;
p = 2;
for i = (1:N-1)
	p = p * 2;
	s = s + p * (a(i+1,1)^2 - (a(i+1,2)^2));
	piapprox = 4 * a(i+1,1)^2 / (1 - s)
end

pi
