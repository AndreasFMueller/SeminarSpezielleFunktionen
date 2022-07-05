/*
 * lemnispara.cpp -- Display parametrisation of the lemniskate
 *
 * (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <gsl/gsl_sf_elljac.h>
#include <iostream>
#include <fstream>
#include <map>
#include <string.h>
#include <string>

const static double	s = sqrt(2);
const static double	k = 1 / s;
const static double	m = k * k;

typedef std::pair<double, double>	point_t;

point_t	operator*(const point_t& p, double s) {
	return point_t(s * p.first, s * p.second);
}

static double	norm(const point_t& p) {
	return hypot(p.first, p.second);
}

static point_t	normalize(const point_t& p) {
	return p * (1/norm(p));
}

static point_t	normal(const point_t& p) {
	return std::make_pair(p.second, -p.first);
}

class lemniscate : public point_t {
	double	sn, cn, dn;
public:
	lemniscate(double t) {
		gsl_sf_elljac_e(t, m, &sn, &cn, &dn);
		first = s * cn * dn;
		second = cn * sn;
	}
	point_t	tangent() const {
		return std::make_pair(-s * sn * (1.5 - sn * sn),
				dn * (1 - 2 * sn * sn));
	}
	point_t	unittangent() const {
		return normalize(tangent());
	}
	point_t	normal() const {
		return ::normal(tangent());
	}
	point_t	unitnormal() const {
		return ::normal(unittangent());
	}
};

std::ostream&	operator<<(std::ostream& out, const point_t& p) {
	char	b[1024];
	snprintf(b, sizeof(b), "({%.4f*\\dx},{%.4f*\\dy})", p.first, p.second);
	out << b;
	return out;
}

int	main(int argc, char *argv[]) {
	std::ofstream	out("lemnisparadata.tex");

	// the curve
	double	tstep = 0.01;
	double tmax = 4.05;
	out << "\\def\\lemnispath{ ";
	out << lemniscate(0);
	for (double t = tstep; t < tmax; t += tstep) {
		out << std::endl << "\t" << "-- " << lemniscate(t);
	}
	out << std::endl;
	out << "}" << std::endl;

	out << "\\def\\lemnispathmore{ ";
	out << lemniscate(tmax);
	double	tmax2 = 7.5;
	for (double t = tmax + tstep; t < tmax2; t += tstep) {
		out << std::endl << "\t" << "-- " << lemniscate(t);
	}
	out << std::endl;
	out << "}" << std::endl;

	// individual points
	tstep = 0.2;
	int	i = 0;
	char	name[3];
	strcpy(name, "L0");
	for (double t = 0; t <= tmax; t += tstep) {
		char	c = 'A' + i++;
		char	buffer[128];
		lemniscate	l(t);
		name[0] = 'L';
		name[1] = c;
		out << "\\coordinate (" << name << ") at ";
		out << l << ";" << std::endl;
		name[0] = 'T';
		out << "\\coordinate (" << name << ") at ";
		out << l.unittangent() << ";" << std::endl;
		name[0] = 'N';
		out << "\\coordinate (" << name << ") at ";
		out << l.unitnormal() << ";" << std::endl;
		name[0] = 'C';
		out << "\\def\\" << name << "{ ";
		out << "\\node[color=red] at ($(L" << c << ")+0.06*(N" << c << ")$) ";
		out << "[rotate={";
		double	w = 180 * atan2(l.unitnormal().second,
					l.unitnormal().first) / M_PI;
		snprintf(buffer, sizeof(buffer), "%.1f", w);
		out << buffer;
		out << "-90}]";
		snprintf(buffer, sizeof(buffer), "%.1f", t);
		out << " {$\\scriptstyle " << buffer << "$};" << std::endl;
		out << "}" << std::endl;
	}

	out.close();
	return EXIT_SUCCESS;
}
