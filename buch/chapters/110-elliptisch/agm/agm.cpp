/*
 * agm.cpp
 *
 * (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <iostream>
#include <gsl/gsl_sf_ellint.h>

inline long double	sqrl(long double x) {
	return x * x;
}

long double	Xn(long double a, long double b, long double x) {
	double long	epsilon = fabsl(a - b);
	if (epsilon > 0.001) {
		return (a - sqrtl(sqrl(a) - sqrl(x) * (a + b) * (a - b)))
			/ (x * (a - b));
	}
	long double	d = a + b;
	long double	x1 = 0;
	long double	y2 = sqrl(x/a);
	long double	c = 1;
	long double	s = 0;
	int	k = 1;
	while (c > 0.0000000000001) {
		c *= (0.5 - (k - 1)) / k;
		c *= (d - epsilon) * y2;
		s += c;
		c *= epsilon;
		c = -c;
		k++;
	}
	return s * a / x;
}

int	main(int argc, char *argv[]) {
	long double	a = 1;
	long double	b = sqrtl(2.)/2;
	long double	x = 0.7;
	if (argc >= 3) {
		a = std::stod(argv[1]);
		b = std::stod(argv[2]);
	}
	if (argc >= 4) {
		x = std::stod(argv[3]);
	}

	{
		long double	an = a;
		long double	bn = b;
		long double	xn = x;
		for (int i = 0; i < 10; i++) {
			printf("%d  %24.18Lf  %24.18Lf  %24.18Lf  %24.18Lf\n",
				i, an, bn, xn, a * asin(xn) / an);
			long double A = (an + bn) / 2;
			xn = Xn(an, bn, xn);
			bn = sqrtl(an * bn);
			an = A;
		}
	}

	{
		double	k = b/a;
		k = sqrt(1 - k*k);
		double	K = gsl_sf_ellint_Kcomp(k, GSL_PREC_DOUBLE);
		printf("                             %24.18f  %24.18f\n", k, K);
		double	F = gsl_sf_ellint_F(asinl(x), k, GSL_PREC_DOUBLE);
		printf("                             %24.18f  %24.18f\n", k, F);
	}

	return EXIT_SUCCESS;
}
