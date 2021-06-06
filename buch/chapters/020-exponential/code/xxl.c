/*
 * xxl.c -- find solution of x^x = 27
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschue
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <gsl/gsl_sf_lambert.h>

int	main(int argc, char *argv[]) {
	double	b = 27;
	double	w = gsl_sf_lambert_W0(log(b));
	printf("W_0(log(27))  = %f\n", w);
	double	x = exp(w);
	printf("x             = %f\n", x);

	return EXIT_SUCCESS;
}
