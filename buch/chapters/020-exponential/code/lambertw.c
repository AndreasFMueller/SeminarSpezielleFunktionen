/*
 * lambertw.c
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include <math.h>

static double	precision = 1e-16;
static FILE	*logfile = NULL;

double	f(double x) {
	return x * exp(x);
}

double	lambertW0(double y) {
	double	x = log(1 + y);
	double	delta = 1;
	int	count = 0;
	while ((count < 20) && (delta > precision)) {
		double	error = f(x) - y;
		if (logfile) {
			fprintf(logfile, "%20.16f    %20.16f\n", x, error);
		}
		double	xnew = x - error / ((1 + x) * exp(x));
		delta = fabs(xnew - x);
		x = xnew;
		count++;
	}
	if (count == 0) {
		fprintf(stderr, "count exceeded\n");
		return -1;
	}
	if (logfile) {
		fprintf(logfile, "%d\n", count);
	}
	return x;
}

double	lambertW1(double y) {
	double	x = log(-y);
	double	delta = 1;
	int	count = 0;
	while ((count < 20) && (delta > precision)) {
		double	error = f(x) - y;
		if (logfile) {
			fprintf(logfile, "%20.16f    %20.16f\n", x, error);
		}
		double	xnew = x - error / ((1 + x) * exp(x));
		delta = fabs(xnew - x);
		x = xnew;
		count++;
	}
	if (count == 0) {
		fprintf(stderr, "count exceeded\n");
		return -1;
	}
	if (logfile) {
		fprintf(logfile, "%d\n", count);
	}
	return x;
}

struct option	options[] = {
{	"precision",	required_argument,	NULL,	'p'	},
{	"logfile",	required_argument,	NULL,	'l'	},
{	"minus",	no_argument,		NULL,	'm'	},
{	NULL,		0,			NULL,    0	}
};

int	main(int argc, char *argv[]) {
	int	c;
	int	l;
	int	minusone = 0;
	while (EOF != (c = getopt_long(argc, argv, "p:l:m", options, &l)))
		switch (c) {
		case 'l':
			logfile = fopen(optarg, "w");
			break;
		case 'p':
			precision = atof(optarg);
			break;
		case 'm':
			minusone = 1;
			break;
		}

	for (; optind < argc; optind++) {
		double	y = atof(argv[optind]);
		double	x = (y >= 0) ? lambertW0(y) :
				((minusone) ? lambertW1(y) : lambertW0(y));
		printf("%20.16f -> %20.16f  (%20.16f)\n", x, y, y - f(x));
	}

	if (logfile) {
		fclose(logfile);
	}

	return EXIT_SUCCESS;
}
