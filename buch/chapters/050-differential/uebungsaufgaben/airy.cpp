/*
 * airy.cpp
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <getopt.h>
#include <gsl/gsl_sf_hyperg.h>

bool	debug = false;

struct option	options[] = {
{ "debug",	no_argument,		0,		'd' },
{ "outfile",	required_argument,	0,		'o' },
{ "a",		required_argument,	0,		'a' },
{ "b",		required_argument,	0,		'b' },
{ "s",		required_argument,	0,		's' },
{ NULL,		0,			0,		 0  }
};

double	h0f1(double c, double x) {
	if (debug)
		fprintf(stderr, "%s:%d: c = %.5f, x = %.5f\n",
			__FILE__, __LINE__, c, x);
	double	s = 0;
	int	k = 0;
	double	term = 1.;
	s += term;
	int	counter = 0;
	while (fabs(term) > 0.000000000001) {
		k++;
		term *= x / ((c+k-1) * k);
		s += term;
	//	if (debug)
	//		fprintf(stderr, "term = %.14f\n", term);
		counter++;
	}
	if (debug)
		fprintf(stderr, "x = %f, terms = %d\n", x, counter);
	return s;
}

double	f0(double x) {
	//return gsl_sf_hyperg_0F1(2/3, x*x*x/9.);
	return h0f1(2./3., x*x*x/9.);
}
double	f1(double x) {
	//return gsl_sf_hyperg_0F1(2/3, x*x*x/9.);
	return h0f1(2./3., x*x*x/9.);
}

double	f2(double x) {
	return x * gsl_sf_hyperg_0F1(4./3., x*x*x/9.);
}

double	f3(double x) {
	return x * h0f1(4./3., x*x*x/9.);
}

void	plot(FILE *outfile, const char *name, double (*f)(double x),
		double a, double b, int steps) {
	fprintf(outfile, "\\def\\%s{\n", name);
	fprintf(outfile, "({%.5f*\\dx},{%.5f*\\dy})", a, f(a));
	double	h = (b-a)/steps;
	for (int i = 0; i <= steps; i++) {
		double	x = a + h*i;
		if (debug)
			fprintf(stderr, "x = %.5f\n", x);
		fprintf(outfile, "\n\t--({%.5f*\\dx},{%.5f*\\dy})",
			x, f(x));
	}
	fprintf(outfile, "}\n");
}

int	main(int argc, char *argv[]) {
	std::string	outfilename("airypaths.tex");
	int	c;
	int	longindex;
	double	a = -8;
	double	b = 2.5;
	int	steps = 200;
	while (EOF != (c = getopt_long(argc, argv, "a:b:do:s:",
		options, &longindex)))
		switch (c) {
		case 'a':
			a = std::stod(optarg);
			break;
		case 'b':
			b = std::stod(optarg);
			break;
		case 'd':
			debug = true;
			break;
		case 'o':
			outfilename = std::string(optarg);
			break;
		case 's':
			steps = std::stoi(optarg);
			break;
		}

	if (debug)
		fprintf(stderr, "%s:%d: outfile: '%s'\n",
			__FILE__, __LINE__, outfilename.c_str());

	FILE	*outfile = fopen(outfilename.c_str(), "w");

	plot(outfile, "yonepath", f1, a, b, 100);
	plot(outfile, "ytwopath", f2, a, b, 100);
	plot(outfile, "ythreepath", f3, a, b, 100);
	
	fclose(outfile);

	return EXIT_SUCCESS;
}
