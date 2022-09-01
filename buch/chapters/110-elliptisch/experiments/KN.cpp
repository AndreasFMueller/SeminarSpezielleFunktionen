/*
 * KN.cpp
 *
 * (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <iostream>
#include <fstream>
#include <sstream>
#include <getopt.h>
#include <vector>
#include <gsl/gsl_sf_elljac.h>
#include <gsl/gsl_sf_ellint.h>

namespace KN {

bool	debug = false;

static struct option	longopts[] {
{ "debug",	no_argument,		NULL,	'd' },
{ "N",		required_argument,	NULL,	'N' },
{ "outfile",	required_argument,	NULL,	'o' },
{ "min",	required_argument,	NULL,	'm' },
{ NULL,		0,			NULL,	 0  }
};

double	KprimeK(double k) {
	double	kprime = sqrt(1-k*k);
	if (debug)
		printf("%s:%d: k = %f, k' = %f\n", __FILE__, __LINE__, k, kprime);
	double	v
		=
		gsl_sf_ellint_Kcomp(k, GSL_PREC_DOUBLE)
		/
		gsl_sf_ellint_Kcomp(kprime, GSL_PREC_DOUBLE)
		;
	if (debug)
		printf("%s:%d: KprimeK(k = %f) = %f\n", __FILE__, __LINE__, k, v);
	return v;
}

static const int	L = 100000000;
static const double	h = 1. / L;

double	Kd(double k) {
	double	m = 0;
	if (k < h) {
		m = 2 * (KprimeK(k) - KprimeK(k / 2)) / k;
	} else if (k > 1-h) {
		m = 2 * (KprimeK((1 + k) / 2) - KprimeK(k)) / (1 - k);
		
	} else {
		m = L * (KprimeK(k + h) - KprimeK(k));
	}
	if (debug)
		printf("%s:%d: Kd(%f) = %f\n", __FILE__, __LINE__, k, m);
	return m;
}

double	k1(double y) {
	if (debug)
		printf("%s:%d: Newton for y = %f\n", __FILE__, __LINE__, y);
	double	kn = 0.5;
	double	delta = 1;
	int	n = 0;
	while ((fabs(delta) > 0.000001) && (n < 10)) {
		double	yn = KprimeK(kn);
		if (debug)
			printf("%s:%d: k%d = %f, y%d = %f\n", __FILE__, __LINE__, n, kn, n, yn);
		delta = (yn - y) / Kd(kn);
		if (debug)
			printf("%s:%d: delta = %f\n", __FILE__, __LINE__, delta);
		double	kneu = kn - delta;
		if (kneu <= 0) {
			kneu = kn / 4;
		}
		if (kneu >= 1) {
			kneu = (3 + kn) / 4;
		}
		kn = kneu;
		if (debug)
			printf("%s:%d: kneu = %f, kn = %f\n", __FILE__, __LINE__, kneu, kn);
		n++;
	}
	if (debug)
		printf("%s:%d: Newton result: k = %f\n", __FILE__, __LINE__, kn);
	return kn;
}

double	k1(int N, double k) {
	return k1(KprimeK(k) / N);
}

/**
 * \brief Main function for the slcl program
 */
int	main(int argc, char *argv[]) {
	int	longindex;
	int	c;
	int	N = 5;
	double	kmin = 0.01;
	std::string	outfilename;
	while (EOF != (c = getopt_long(argc, argv, "d:N:o:m:",
		longopts, &longindex)))
		switch (c) {
		case 'd':
			debug = true;
			break;
		case 'N':
			N = std::stoi(optarg);
			break;
		case 'o':
			outfilename = std::string(optarg);
			break;
		case 'm':
			kmin = std::stod(optarg);
			break;
		}

	double	d = 0.01;
	if (outfilename.size() > 0) {
		FILE	*fn = fopen(outfilename.c_str(), "w");
		fprintf(fn, "\\def\\KKpath{ ");
		double	k = d;
		fprintf(fn, " (0,0)");
		double	k0 = k/16;
		while (k0 < k) {
			fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})", k0, KprimeK(k0));
			k0 *= 2;
		}
		while (k < 1-0.5*d) {
			fprintf(fn, "\n\t-- ({%.4f*\\dx},{%.4f*\\dy})", k, KprimeK(k));
			k += d;
		}
		fprintf(fn, "}\n");

		k0 = 0.97;
		fprintf(fn, "\\def\\knull{%.4f}\n", k0);
		double	KK = KprimeK(k0);
		fprintf(fn, "\\def\\KKnull{%.4f}\n", KK);
		fprintf(fn, "\\def\\kone{%.4f}\n", k1(N, k0));

		fclose(fn);
		return EXIT_SUCCESS;
	}

	for (double k = kmin; k < (1 - d/2); k += d) {
		if (debug)
			printf("%s:%d: k = %f\n", __FILE__, __LINE__, k);
		double	y = KprimeK(k);
		double	k0 = k1(y);
		double	kone = k1(N, k0);
		printf("g(%4.2f) = %10.6f,", k, y);
		printf("    g'(%.2f) = %10.6f,", k, Kd(k));
		printf("    g^{-1} = %10.6f,", k0);
		printf("    k1 = %10.6f,", kone);
		printf("    g(k1) = %10.6f\n", KprimeK(kone));
	}

	return EXIT_SUCCESS;
}

} // namespace KN

int	main(int argc, char *argv[]) {
	try {
		return KN::main(argc, argv);
	} catch (const std::exception& e) {
		std::cerr << "terminated by exception: " << e.what();
		std::cerr << std::endl;
	} catch (...) {
		std::cerr << "terminated by unknown exception" << std::endl;
	}
	return EXIT_FAILURE;
}
