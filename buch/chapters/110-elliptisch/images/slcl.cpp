/*
 * slcl.cpp
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

namespace slcl {

static struct option	longopts[] {
{ "outfile",	required_argument,	NULL,	'o' },
{ "a",		required_argument,	NULL,	'a' },
{ "b",		required_argument,	NULL,	'b' },
{ "steps",	required_argument,	NULL,	'n' },
{ NULL,		0,			NULL,	 0  }
};

class plot {
	typedef std::pair<double, double>	point_t;
	typedef std::vector<point_t>	curve_t;
	curve_t	_sl;
	curve_t	_cl;
	double	_a;
	double	_b;
	int	_steps;
public:
	double 	a() const { return _a; }
	double 	b() const { return _b; }
	int	steps() const { return _steps; }
public:
	plot(double a, double b, int steps) : _a(a), _b(b), _steps(steps) {
		double	l = sqrt(2);
		double	k = 1 / l;
		double	m = k * k;
		double	h = (b - a) / steps;
		for (int i = 0; i <= steps; i++) {
			double	x = a + h * i;
			double	sn, cn, dn;
			gsl_sf_elljac_e(x, m, &sn, &cn, &dn);
			_sl.push_back(std::make_pair(l * x, k * sn / dn));
			_cl.push_back(std::make_pair(l * x, cn));
		}
	}
private:
	std::string	point(const point_t p) const {
		char	buffer[128];
		snprintf(buffer, sizeof(buffer), "({%.4f*\\dx},{%.4f*\\dy})",
			p.first, p.second);
		return std::string(buffer);
	}
	std::string	path(const curve_t& curve) const {
		std::ostringstream	out;
		auto i = curve.begin();
		out << point(*(i++));
		do {
			out << std::endl << "   -- " << point(*(i++));
		} while (i != curve.end());
		out.flush();
		return out.str();
	}
public:
	std::string	slpath() const {
		return path(_sl);
	}
	std::string	clpath() const {
		return path(_cl);
	}
};

/**
 * \brief Main function for the slcl program
 */
int	main(int argc, char *argv[]) {
	int	longindex;
	int	c;
	double	a = 0;
	double	b = 10;
	int	steps = 100;
	std::ostream	*out = &std::cout;
	while (EOF != (c = getopt_long(argc, argv, "a:b:o:n:",
		longopts, &longindex)))
		switch (c) {
		case 'a':
			a = std::stod(optarg);
			break;
		case 'b':
			b = std::stod(optarg) / sqrt(2);
			break;
		case 'n':
			steps = std::stol(optarg);
			break;
		case 'o':
			out = new std::ofstream(optarg);
			break;
		}

	plot	p(a, b, steps);
	(*out) << "\\def\\slpath{ " << p.slpath();
	(*out) << std::endl << " }" << std::endl;
	(*out) << "\\def\\clpath{ " << p.clpath();
	(*out) << std::endl << " }" << std::endl;

	out->flush();
	//out->close();
	return EXIT_SUCCESS;
}

} // namespace slcl

int	main(int argc, char *argv[]) {
	try {
		return slcl::main(argc, argv);
	} catch (const std::exception& e) {
		std::cerr << "terminated by exception: " << e.what();
		std::cerr << std::endl;
	} catch (...) {
		std::cerr << "terminated by unknown exception" << std::endl;
	}
	return EXIT_FAILURE;
}
