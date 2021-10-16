/*
 * rechteck.cpp
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cmath>
#include <cstdlib>
#include <cstdio>
#include <complex>
#include <iostream>

double	ast = 1;

std::complex<double>	integrand(double k, const std::complex<double>& z) {
	std::complex<double>	s = z * z;
	std::complex<double>	eins(1);
	std::complex<double>	result = eins / sqrt((eins - s) * (eins - k * k * s));
	return ast * ((result.imag() < 0) ? -result : result);
}

std::complex<double>	segment(double k, const std::complex<double>& z1,
		const std::complex<double>& z2, int n = 100) {
	std::complex<double>	dz = z2 - z1;
	std::complex<double>	summe(0);
	double	h = 1. / n;
	summe = integrand(k, z1);
	summe += integrand(k, z2);
	for (int i = 1; i < n; i++) {
		double	t = i * h;
		std::complex<double>	z = (1 - t) * z1 + t * z2;
		summe += 2. * integrand(k, z);
	}
	return dz * h * summe / 2.;
}

int	main(int argc, char *argv[]) {
	double	k = 0.5;
	double	y = -0.0001;
	double	xstep = -0.1;
	ast = 1;
	std::complex<double>	z(0, y);
	std::complex<double>	w = segment(k, std::complex<double>(0), z);
	std::cout << z << std::endl;
	int	counter = 100;
	while (counter-- > 0) {
		std::complex<double>	znext = z + std::complex<double>(xstep);
		std::complex<double>	incr = segment(k, z, znext);
		w += incr;
		std::cout << znext << " -> " << w << ", ";
		std::cout << integrand(k, znext) << std::endl;
		z = znext;
	}
	return EXIT_SUCCESS;
}
