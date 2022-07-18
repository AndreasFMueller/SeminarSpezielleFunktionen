#
# landen.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
N = 10;

function retval = M(a,b)
	for i = (1:10)
		A = (a+b)/2;
		b = sqrt(a*b);
		a = A;
	endfor
	retval = a;
endfunction;

function retval = EllipticKk(k)
	retval = pi / (2 * M(1, sqrt(1-k^2)));
endfunction

k = 0.5;
kprime = sqrt(1-k^2);

EK = EllipticKk(k);
EKprime = EllipticKk(kprime);

u = EK + EKprime * i;

K = zeros(N,3);
K(1,1) = k;
K(1,2) = kprime;
K(1,3) = u;

format long

for n = (2:N)
	K(n,1) = (1-K(n-1,2)) / (1+K(n-1,2));
	K(n,2) = sqrt(1-K(n,1)^2);
	K(n,3) = K(n-1,3) / (1 + K(n,1));
end

K(:,[1,3])

pi / 2

scd = zeros(N,3);
scd(N,1) = sin(K(N,3));
scd(N,2) = cos(K(N,3));
scd(N,3) = 1;

for n = (N:-1:2)
	nenner = 1 + K(n,1) * scd(n, 1)^2;
	scd(n-1,1) = (1+K(n,1)) * scd(n, 1) / nenner;
	scd(n-1,2) = scd(n, 2) * scd(n, 3) / nenner;
	scd(n-1,3) = (1 - K(n,1) * scd(n,1)^2) / nenner;
end

scd(:,1)

cosh(2.009459377005286)
