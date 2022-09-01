/*
 * 0f1.cpp
 *
 * (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <string>
#include <iostream>
#include <fstream>

static int	N = 100;
static double	xmin = -50;
static double	xmax =  30;
static int	points = 200;

double	f(double b, double x) {
	double	s = 1;
	double	p = 1;
	for (int k = 1; k < N; k++) {
		p = p * x / (k * (b + k - 1.));
		s += p;
	}
	return s;
}

typedef	std::pair<double, double> point_t;

point_t	F(double b, double x) {
	return std::make_pair(x, f(b, x));
}

std::string	ff(double f) {
	if (f > 1000) { f = 1000; }
	if (f < -1000) { f = -1000; }
	char	b[128];
	snprintf(b, sizeof(b), "%.4f", f);
	return std::string(b);
}

std::ostream&	operator<<(std::ostream& out, const point_t& p) {
	char	b[128];
	out << "({" << ff(p.first) << "*\\dx},{" << ff(p.second) << "*\\dy})";
	return out;
}

void	curve(std::ostream& out, double b, const std::string& name) {
	double	h = (xmax - xmin) / points;
	out << "\\def\\kurve" << name << "{";
	out << std::endl << "\t" << F(b, xmin);
	for (int i = 1; i <= points; i++) {
		double	x = xmin + h * i;
		out << std::endl << "\t-- " << F(b, x);
	}
	out << std::endl;
	out << "}" << std::endl;
}

int	main(int argc, char *argv[]) {
	std::ofstream	out("0f1data.tex");

	double	s = 13/(xmax-xmin);
	out << "\\def\\dx{" << ff(s) << "}" << std::endl;
	out << "\\def\\dy{" << ff(s) << "}" << std::endl;
	out << "\\def\\xmin{" << ff(s * xmin) << "}" << std::endl;
	out << "\\def\\xmax{" << ff(s * xmax) << "}" << std::endl;

	curve(out, 0.5, "one");
	curve(out, 1.5, "two");
	curve(out, 2.5, "three");
	curve(out, 3.5, "four");
	curve(out, 4.5, "five");
	curve(out, 5.5, "six");
	curve(out, 6.5, "seven");
	curve(out, 7.5, "eight");
	curve(out, 8.5, "nine");
	curve(out, 9.5, "ten");

	curve(out,-0.5, "none");
	curve(out,-1.5, "ntwo");
	curve(out,-2.5, "nthree");
	curve(out,-3.5, "nfour");
	curve(out,-4.5, "nfive");
	curve(out,-5.5, "nsix");
	curve(out,-6.5, "nseven");
	curve(out,-7.5, "neight");
	curve(out,-8.5, "nnine");
	curve(out,-9.5, "nten");
	
	out.close();
	return EXIT_SUCCESS;
}
