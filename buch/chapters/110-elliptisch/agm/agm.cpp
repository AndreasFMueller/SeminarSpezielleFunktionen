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



int	main(int argc, char *argv[]) {
	long double	a = 1;
	long double	b = sqrtl(2.)/2;
	if (argc >= 3) {
		a = std::stod(argv[1]);
		b = std::stod(argv[2]);
	}

	{
		long double	an = a;
		long double	bn = b;
		for (int i = 0; i < 10; i++) {
			printf("%d  %24.18Lf  %24.18Lf  %24.18Lf\n",
				i, an, bn, a * M_PI / (2 * an));
			long double A = (an + bn) / 2;
			bn = sqrtl(an * bn);
			an = A;
		}
	}

	{
		double	k = b/a;
		k = sqrt(1 - k*k);
		double	K = gsl_sf_ellint_Kcomp(k, GSL_PREC_DOUBLE);
		printf("                             %24.18f  %24.18f\n", k, K);
	}

	return EXIT_SUCCESS;
}
