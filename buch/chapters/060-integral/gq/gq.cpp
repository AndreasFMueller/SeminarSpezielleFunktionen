/*
 * gq.cpp -- Gauss Quadrature Example
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <gsl/gsl_integration.h>

int	counter;

double	f(double x, void *) {
	counter++;
	return sqrt(1-x*x);
}

void	do_integration(size_t n, const char *name) {
	double	scaling = 1e6;
	// set up integration gauss quadrature
	counter = 0;
	gsl_function	func;
	func.function = f;
	func.params = NULL;

	// prepare plotting of results
	int	steps = 200;
	double	h = 1. / steps;

	printf("\\def\\%s{\n\t(0,0)", name);
	for (int i = 1; i <= steps; i++) {
		double	a = i * h;
		a = 1 - (1 - a) * (1 - a);
		double	expected = (asin(a) + a * sqrt(1 - a*a)) / 2;
		gsl_integration_fixed_workspace	*ws
			= gsl_integration_fixed_alloc(
				gsl_integration_fixed_legendre,
				n, 0, a, 0, 0);
		double	result = 0;
		gsl_integration_fixed(&func, &result, ws);
		double	y = fabs(scaling * (result - expected));
		if (y > 10) {
			y = 10;
		}
		printf("\n\t--({\\dx*%.4f},{\\dy*%.6f})", a, y);
		gsl_integration_fixed_free(ws);
	}
	printf("\n}\n");
}

int	main(int argc, char *argv[]) {
	do_integration(2, "two");
	do_integration(4, "four");
	do_integration(6, "six");
	do_integration(8, "eight");
	do_integration(10, "ten");
	do_integration(12, "twelve");
	do_integration(14, "fourteen");
	do_integration(16, "sixteen");

	return EXIT_SUCCESS;
}
