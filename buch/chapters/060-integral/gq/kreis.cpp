/*
 * kreis.cpp -- Gauss Quadrature Example
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <gsl/gsl_integration.h>

double	xmax = 0.990;

double	f(double x, void *) {
	return sqrt(1-x*x);
}

double	do_integration(size_t n) {
	// set up integration gauss quadrature
	gsl_function	func;
	func.function = f;
	func.params = NULL;

	gsl_integration_fixed_workspace	*ws
		= gsl_integration_fixed_alloc(
			gsl_integration_fixed_legendre,
			n, -xmax, xmax, 0, 0);
	double	result = 0;
	gsl_integration_fixed(&func, &result, ws);
	gsl_integration_fixed_free(ws);
	return result;
}

double	do_trapez(size_t n) {
	double	h = 2 * xmax / n;	
	double	s = 0;
	for (int i = 0; i <= n; i++) {
		double	x = -xmax + i * h;
		double	a = f(x, NULL);
		if ((i == 0) || (i == n)) {
			a = a * 0.5;
		}
		s += a;
	}
	return h * s;
}

void	do_table(double limit) {
	xmax = limit;
	for (int n = 2; n <= 20; n += 2) {
		printf("%d & %.16f & %.16f \\\\\n", n, do_integration(n),
			do_trapez(10 * n));
	}
	double	amax = acos(xmax);
	double	expected = (M_PI / 2 - amax) + sin(amax) * cos(amax);
	printf("\\infty & %.16f & %.16f \\\\\n", expected, expected);
}

int	main(int argc, char *argv[]) {
	do_table(0.5);
	do_table(0.9);
	do_table(0.99);
	do_table(0.999);
	return EXIT_SUCCESS;
}
