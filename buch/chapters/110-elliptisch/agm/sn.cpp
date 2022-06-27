/*
 * ns.cpp
 *
 * (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <iostream>
#include <gsl/gsl_sf_ellint.h>
#include <gsl/gsl_sf_elljac.h>

static const int	N = 10;

inline long double	sqrl(long double x) {
	return x * x;
}

int	main(int argc, char *argv[]) {
	long double	u = 0.6;
	long double	k = 0.9;
	long double	kprime = sqrt(1 - sqrl(k));
	
	long double	a[N], b[N], x[N+1];
	a[0] = 1;
	b[0] = kprime;

	for (int n = 0; n < N-1; n++) {
		printf("a[%d] = %22.18Lf  b[%d] = %22.18Lf\n", n, a[n], n, b[n]);
		a[n+1] = (a[n] + b[n]) / 2;
		b[n+1] = sqrtl(a[n] * b[n]);
	}

	x[N] = sinl(u * a[N-1]);
	printf("x[%d] = %22.18Lf\n", N, x[N]);

	for (int n = N - 1; n >= 0; n--) {
		x[n] = 2 * a[n] * x[n+1] / (a[n] + b[n] + (a[n] - b[n]) * sqrl(x[n+1]));
		printf("x[%2d] = %22.18Lf\n", n, x[n]);
	}
	
	printf("sn(%7.4Lf, %7.4Lf) = %20.24Lf\n", u, k, x[0]);

	double	sn, cn, dn;
	double	m = sqrl(k);
	gsl_sf_elljac_e((double)u, m, &sn, &cn, &dn);
	printf("sn(%7.4Lf, %7.4Lf) = %20.24f\n", u, k, sn);
	printf("cn(%7.4Lf, %7.4Lf) = %20.24f\n", u, k, cn);
	printf("dn(%7.4Lf, %7.4Lf) = %20.24f\n", u, k, dn);

	return EXIT_SUCCESS;
}
