/*
 * jacobi.cpp
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <gsl/gsl_sf_elljac.h>
#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>
#include <getopt.h>

namespace jacobi {

static struct option	longopts[] {
{ "k",		required_argument,	NULL,	'k' },
{ "m",		required_argument,	NULL,	'm' },
{ "outfile",	required_argument,	NULL,	'o' },
{ "infile",	required_argument,	NULL,	'i' },
{ "umin",	required_argument,	NULL,	'f' },
{ "umax",	required_argument,	NULL,	't' },
{ "steps",	required_argument,	NULL,	's' },
{ NULL,		0,			NULL,	 0  }
};

/**
 * \brief A class to contain a single plot
 */
class jacobiplot : public std::vector<std::pair<double,double> > {
	std::string	punkt(std::pair<double,double> x) const {
		char	buffer[128];
		snprintf(buffer, sizeof(buffer), "({%.4f*\\dx},{%.4f*\\dy})",
			x.first, x.second);
		return std::string(buffer);
	}
public:
	jacobiplot() { }
	void	write(std::ostream& out, const std::string& name) const {
		out << "\\def\\" << name << "{" << std::endl;
		auto	i = begin();
		out << punkt(*i);
		for (i++; i != end(); i++) {
			out << std::endl << " -- " << punkt(*i);
		}
		out << std::endl << "}" << std::endl;
	}
};

/**
 * \brief A class containing all three basic functions
 */
class jacobiplots {
	jacobiplot	_sn;
	jacobiplot	_cn;
	jacobiplot	_dn;
	double	_m;
public:
	const jacobiplot&	sn() const { return _sn; }
	const jacobiplot&	cn() const { return _cn; }
	const jacobiplot&	dn() const { return _dn; }
	jacobiplots(double m) : _m(m) { }
	double	m() const { return _m; }
	void	add(double umin, double umax, int steps) {
		_sn.clear();
		_cn.clear();
		_dn.clear();
		double	h = (umax - umin) / steps;
		for (int i = 0; i <= steps; i++) {
			double	u = umin + i * h;
			double	snvalue, cnvalue, dnvalue;
			gsl_sf_elljac_e(u, m(), &snvalue, &cnvalue, &dnvalue);
			_sn.push_back(std::make_pair(u, snvalue));
			_cn.push_back(std::make_pair(u, cnvalue));
			_dn.push_back(std::make_pair(u, dnvalue));
		}
	}
	void	write(std::ostream& out, const std::string& name) const {
		out << "% name=" << name << ", m=" << m() << std::endl;
		out << "\\def\\m" << name << "{" << m() << "}" << std::endl;
		_sn.write(out, std::string("sn") + name);
		_cn.write(out, std::string("cn") + name);
		_dn.write(out, std::string("dn") + name);
	}
};

int	main(int argc, char *argv[]) {
	int	c;
	int	longindex;
	std::ostream	*out = &std::cout;
	std::string	infilename;
	int	steps = 100;
	double	umin = 0;
	double	umax = 10;
	while (EOF != (c = getopt_long(argc, argv, "o:i:f:t:s:", longopts,
		&longindex)))
		switch (c) {
		case 'o':
			out = new std::ofstream(optarg);
			(*out) << "%" << std::endl;
			(*out) << "% " << optarg << std::endl;
			(*out) << "%" << std::endl;
			break;
		case 'i':
			infilename = std::string(optarg);
			break;
		case 'f':
			umin = std::stod(optarg);
			break;
		case 't':
			umax = std::stod(optarg);
			break;
		case 's':
			steps = std::stoi(optarg);
			break;
		}

	if (infilename.size() == 0) {
		while ((optind + 1) < argc) {
			std::string	name(argv[optind++]);
			double	m = std::stod(argv[optind++]);
			jacobiplots	j(m);
			j.add(umin, umax, steps);
			j.write(*out, name);
		}
	} else {
		std::ifstream	infile(infilename);
		while (!infile.eof()) {
			std::string	name;
			double	m;
			infile >> name;
			infile >> m;
			jacobiplots	j(m);
			j.add(umin, umax, steps);
			j.write(*out, name);
		}
	}

	return EXIT_SUCCESS;
}

} // namespace jacobi

int	main(int argc, char *argv[]) {
	try {
		return jacobi::main(argc, argv);
	} catch (const std::exception& x) {
		std::cerr << "cannot build sn/cn/dn file: " << x.what();
		std::cerr << std::endl;
	}
	return EXIT_FAILURE;
}
