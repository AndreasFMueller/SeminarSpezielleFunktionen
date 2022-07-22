/*
 * l.cpp
 *
 * (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstdlib>
#include <cmath>
#include <cstdio>

int	main(int argc, char *argv[]) {
	double	x = 0.5;
	double	g = tgamma(x);
	printf("limit: %20.16f\n", g);
	double	p = 1;
	long long	N = 100000000000;
	long long	n = 10;
	for (long long k = 1; k <= N; k++) {
		p = p * k / (x + k - 1);
		if (0 == k % n) {
			double	gval = p * pow(k, x-1);
			printf("%12ld  %20.16f %20.16f\n", k, gval, gval - g);
			n = n * 10;
		}
	}
	return EXIT_SUCCESS;
}
