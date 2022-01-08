/*
 * jacobi.cpp
 *
 * (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstdlib>
#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>
#include <memory>
#include <getopt.h>
#include <cmath>

/**
 * \brief Pfad-Klasse
 */
class	pfad {
	std::ostringstream	*_inhalt;
	std::string	_name;
	int	_punkte;
public:
	pfad(const pfad&) = delete;
	pfad(const std::string name) : _name(name), _punkte(0) {
		_inhalt = new std::ostringstream();
	}
	~pfad() {
		if (_inhalt) {
			delete _inhalt;
		}
	}
	void	add(const std::pair<double,double>& XY) {
		if (_punkte == 0) {
			*_inhalt << "\\def\\" + _name + "{\n\t";
		} else {
			*_inhalt << "\n\t-- ";
		}
		*_inhalt << "({";
		*_inhalt << XY.first;
		*_inhalt << "*\\dx},{";
		*_inhalt << XY.second;
		*_inhalt << "*\\dy})";
		_punkte++;
	}
	void	operator()(const std::pair<double,double>& XY) {
		add(XY);
	}
	std::string	macro() const {
		std::string	result = _inhalt->str();
		result = result + ";\n}\n";
		return result;
	}
};
typedef	std::shared_ptr<pfad>	pfad_ptr;

#define	c(k) ((k)+a+b)

std::vector<double>	jacobiP(double a, double b, double x, int n) {
	std::vector<double>	result;
	double	p0 = 1.;
	result.push_back(p0);
	double	p1 = (a - b)/2. + (1. + (a + b)/2.) * x;
	result.push_back(p1);
	int	i = 1;
	while (i++ < n) {
		double	p;
		p = c(2*i-1) * (c(2*i-2) * c(2*i) * x + a*a - b*b) * p1
			- 2. * (i-1.+a) * (i-1.+b) * c(2*i) * p0;
		p /= 2 * i * c(i) * c(2*i-2);
		result.push_back(p);
		p0 = p1;
		p1 = p;
	}
	return result;
}

std::string	jacobiPlots(const std::string& prefix,
			double a, double b, int n, int N) {
	std::vector<pfad_ptr>	pfade;
	for (int j = 0; j <= n; j++) {
		char	c = 'a' + j;
		std::string	name = prefix;
		name.append(1, c);
		pfad_ptr	p(new pfad(name));
		pfade.push_back(p);
	}
	for (int i = -N; i <= N; i++) {
		double	x = i / (double)N;
		std::vector<double>	r = jacobiP(a, b, x, n);
		for (int j = 0; j <= n; j++) {
			std::pair<double,double>	XY
				= std::make_pair(x, r[j]);
			pfade[j]->add(XY);
		}
	}
	std::ostringstream	result;
	for (int j = 0; j <= n; j++) {
		result << pfade[j]->macro();
	}
	return result.str();
}

std::string	jacobiWeight(const std::string& prefix,
			double a, double b, int N) {
	std::ostringstream	out;
	out << "\\def\\" << prefix << "weight{" << std::endl;
	int	_punkte = 0;
	int	starti = -N;
	int	endi = N;
	if (b < 0) {
		starti += 1;
	}
	if (a < 0) {
		endi -= 1;
	}
	for (int i = starti; i <= endi; i++) {
		double	x = i / (double)N;
		double	y = pow(1-x, a) * pow(1+x, b);
		if (_punkte > 0) {
			out << std::endl << "\t-- ";
		}
		out << "({" << x << "*\\dx},{" << y << "*\\dwy})";
		_punkte++;
	}
	out << std::endl << "}" << std::endl;
	return out.str();
}

struct option 	options[] = {
{ "a",		required_argument,	NULL,		'a' },
{ "b",		required_argument,	NULL,		'b' },
{ "degree",	required_argument,	NULL,		'n' },
{ "points",	required_argument,	NULL,		'N' },
{ "prefix",	required_argument,	NULL,		'p' },
{ "outfile",	required_argument,	NULL,		'o' },
{ NULL,		0,			NULL,		 0  }
};

int	main(int argc, char *argv[]) {
	int	n = 10;
	int	N = 100;
	double	a = 1;
	double	b = 1;
	std::string	outfilename;
	std::string	prefix("prefix");
	int	c;
	while (EOF != (c = getopt_long(argc, argv, "a:b:n:N:o:p:", options,
		NULL)))
		switch (c) {
		case 'a':
			a = std::stod(optarg);
			break;
		case 'b':
			b = std::stod(optarg);
			break;
		case 'n':
			n = std::stoi(optarg);
			break;
		case 'N':
			N = std::stoi(optarg);
			break;
		case 'o':
			outfilename = std::string(optarg);
			break;
		case 'p':
			prefix = std::string(optarg);
			break;
		}
	std::string	result = jacobiPlots(prefix, a, b, n, N);
	result.append(jacobiWeight(prefix, a, b, N));
	if (outfilename.size() == 0) {
		std::cout << result;
		return EXIT_SUCCESS;
	}
	std::ofstream	out(outfilename.c_str());
	out << result;
	out.close();
	return EXIT_SUCCESS;
}
