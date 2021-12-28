/*
 * 2.c -- solution to problem 2
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <gsl/gsl_sf_lambert.h>

int	main(int argc, char *argv[]) {
	double	s = log(2);
	printf("s = %f\n", s);
	double	t = gsl_sf_lambert_W0(s);
	printf("t = %f\n", t);
	double	y = exp(t);
	printf("y = %f\n", y);
	double	x = atan(y);
	printf("x = %.18f\n", x);
	printf("2 = %f\n", pow(tan(x),tan(x)));
	return EXIT_SUCCESS;
}
