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
#include <fstream>
#include <list>
#include <getopt.h>
#include <gsl/gsl_sf_ellint.h>

double	ast = 1;

/**
 * \brief Base class for integrands
 */
class integrand {
protected:
	double	_k;
public:
	double	k() const { return _k; }
	integrand(double k) : _k(k) { }
	virtual std::complex<double>	operator()(const std::complex<double>& z) const = 0;
	static double	kprime(double k);
};

double	integrand::kprime(double k) {
	return sqrt(1 - k*k);
}

/**
 * \brief Elliptic integral of the first kind
 */
class integrand1 : public integrand {
public:
	integrand1(double k) : integrand(k) { }
	virtual std::complex<double>	operator()(
		const std::complex<double>& z) const {
		std::complex<double>	square = z * z;
		std::complex<double>	eins(1.0);
		std::complex<double>	result = eins
			/ sqrt((eins - square) * (eins - k() * k() * square));
		return ast * ((result.imag() < 0) ? -result : result);
	}
};

/**
 * \brief A class to trace curves
 */
class curvetracer {
	const integrand&	_f;
public:
	typedef std::list<std::complex<double> >	curve_t;
	curvetracer(const integrand& f) : _f(f) { }

	std::complex<double>	startpoint(const std::complex<double>& z,
		int n = 100) const;

	std::complex<double>	segment(const std::complex<double>& z1,
		const std::complex<double>& z2, int n) const;

	std::pair<std::complex<double>,std::complex<double> >	segmentl(
		const std::complex<double>& start,
		const std::complex<double>& dir,
		double stepsize, int n = 10) const;

	curve_t	trace(const std::complex<double>& startz,
		const std::complex<double>& dir,
		const std::complex<double>& startw,
		int maxsteps) const;

	static curve_t	mirrorx(const curve_t& c);
	static curve_t	mirrory(const curve_t& c);
	static curve_t	mirror(const curve_t& c);
};

/**
 * \brief Perform integration for a 
 *
 * \param z1	the start point of the segment in the domain
 * \param z2	the end point of the segment in the domain
 * \param n	the number of integration steps to use
 * \return	the increment along that segment
 */
std::complex<double>	curvetracer::segment(const std::complex<double>& z1,
		const std::complex<double>& z2, int n = 100) const {
	std::complex<double>	dz = z2 - z1;
	std::complex<double>	summe(0);
	double	h = 1. / (2 * n);
	for (int i = 1; i < 2 * n; i += 2) {
		double	t = i * h;
		std::complex<double>	z = (1 - t) * z1 + t * z2;
		summe += _f(z);
	}
	return dz * h * summe * 2.;
}

/**
 * \brief Exception thrown when the number of iterations is exceeded
 */
class toomanyiterations : public std::runtime_error {
public:
	toomanyiterations(const std::string& cause)
		: std::runtime_error(cause) {
	}
};

/**
 * \brief Perform integration with a given target length
 *
 * \param start		the start point
 * \param dir		the direction in which to integrate
 * \param stepsize	the required length of the step
 * \param n		the number of integration steps
 * \return		the increment in the range by this segment
 */
std::pair<std::complex<double>, std::complex<double> >	curvetracer::segmentl(
	const std::complex<double>& start,
	const std::complex<double>& dir,
	double stepsize,
	int n) const {
	std::complex<double>	s(0.);
	std::complex<double>	z = start;
	int	counter = 100;
	while (abs(s) < stepsize) {
		s = s + segment(z, z + dir, n);
		z = z + dir;
		if (counter-- == 0) {
			throw toomanyiterations("too many iterations");
		}
	}
	return std::make_pair(z, s);
}

/**
 * \brief Trace a curve from a starting point in the domain
 *
 * \param startz	the start point of the curve in the domain
 * \param dir		the direction of the curve in the domain
 * \param startw	the initial function value where the curve starts in
 *			the range
 * \param maxsteps	the maximum number of dir-steps before giving up
 * \return		the curve as a list of points
 */
curvetracer::curve_t	curvetracer::trace(const std::complex<double>& startz,
			const std::complex<double>& dir,
			const std::complex<double>& startw,
			int maxsteps) const {
	curve_t	result;
	std::complex<double>	z = startz;
	std::complex<double>	w = startw;
	result.push_back(w);
	while (maxsteps-- > 0) {
		try {
			auto	seg = segmentl(z, dir, abs(dir), 40);
			z = seg.first;
			w = w + seg.second;
			result.push_back(w);
		} catch (const toomanyiterations& x) {
			std::cerr << "iterations exceeded after ";
			std::cerr << result.size();
			std::cerr << " points";
			maxsteps = 0;
		}
	}
	return result;
}

/**
 * \brief Find the initial point for a coordinate curve
 *
 * \param k	the elliptic integral parameter
 * \param z	the desired starting point argument
 */
std::complex<double>	curvetracer::startpoint(const std::complex<double>& z,
		int n) const {
	std::cerr << "start at " << z.real() << "," << z.imag() << std::endl;
	return segment(std::complex<double>(0.), z, n);
}


curvetracer::curve_t	curvetracer::mirrorx(const curve_t& c) {
	curve_t	result;
	for (auto z : c) {
		result.push_back(-std::conj(z));
	}
	return result;
}

curvetracer::curve_t	curvetracer::mirrory(const curve_t& c) {
	curve_t	result;
	for (auto z : c) {
		result.push_back(std::conj(z));
	}
	return result;
}

curvetracer::curve_t	curvetracer::mirror(const curve_t& c) {
	curve_t	result;
	for (auto z : c) {
		result.push_back(-z);
	}
	return result;
}

/**
 * \brief Class to draw the curves to a file
 */
class curvedrawer {
	std::ostream	*_out;
	std::string	_color;
public:
	curvedrawer(std::ostream *out) : _out(out), _color("red") { }
	const std::string&	color() const { return _color; }
	void	color(const std::string& c) { _color = c; }
	void	operator()(const curvetracer::curve_t& curve);
	std::ostream	*out() { return _out; }
};

/**
 * \brief Operator to draw a curve
 *
 * \param curve		the curve to draw
 */
void	curvedrawer::operator()(const curvetracer::curve_t& curve) {
	double	first = true;
	for (auto z : curve) {
		if (first) {
			*_out << "\\draw[color=" << _color << "] ";
			first = false;
		} else {
			*_out << std::endl << "    -- ";
		}
		*_out << "({" << z.real() << "*\\dx},{" << z.imag() << "*\\dy})";
	}
	*_out << ";" << std::endl;
}

static struct option	longopts[] = {
{ "outfile",	required_argument,	NULL,	'o' },
{ "k",		required_argument,	NULL,	'k' },
{ NULL,		0,			NULL,	 0  }
};

/**
 * \brief Main function
 */
int	main(int argc, char *argv[]) {
	double	k = 0.6;

	int	c;
	int	longindex;
	std::string	outfilename;
	while (EOF != (c = getopt_long(argc, argv, "o:k:", longopts, &longindex)))
		switch (c) {
		case 'o':
			outfilename = std::string(optarg);
			break;
		case 'k':
			k = std::stod(optarg);
			break;
		}

	double	kprime = integrand::kprime(k);

	double	xmax = gsl_sf_ellint_Kcomp(k, GSL_PREC_DOUBLE);
	double	ymax = gsl_sf_ellint_Kcomp(kprime, GSL_PREC_DOUBLE);
	std::cout << "xmax = " << xmax << std::endl;
	std::cout << "ymax = " << ymax << std::endl;

	curvedrawer	*cdp;
	std::ofstream	*outfile = NULL;
	if (outfilename.c_str()) {
		outfile = new std::ofstream(outfilename.c_str());
	}
	if (outfile) {
		cdp = new curvedrawer(outfile);
	} else {
		cdp = new curvedrawer(&std::cout);
	}

	integrand1	f(k);
	curvetracer	ct(f);

	// fill
	(*cdp->out()) << "\\fill[color=red!10] ({" << (-xmax) << "*\\dx},0) "
		<< "rectangle ({" << xmax << "*\\dx},{" << ymax << "*\\dy});"
		<< std::endl;
	(*cdp->out()) << "\\fill[color=blue!10] ({" << (-xmax) << "*\\dx},{"
		<< (-ymax) << "*\\dy}) rectangle ({" << xmax << "*\\dx},0);"
		<< std::endl;

	// "circles"
	std::complex<double>	dir(0.01, 0);
	for (double im = 0.2; im < 3; im += 0.2) {
		std::complex<double>	startz(0, im);
		std::complex<double>	startw = ct.startpoint(startz);
		curvetracer::curve_t	curve = ct.trace(startz, dir,
			startw, 1000);
		cdp->color("red");
		(*cdp)(curve);
		(*cdp)(curvetracer::mirrorx(curve));
		cdp->color("blue");
		(*cdp)(curvetracer::mirrory(curve));
		(*cdp)(curvetracer::mirror(curve));
	}

	// imaginary axis
	(*cdp->out()) << "\\draw[color=red] (0,0) -- (0,{" << ymax
		<< "*\\dy});" << std::endl;
	(*cdp->out()) << "\\draw[color=blue] (0,0) -- (0,{" << (-ymax)
		<< "*\\dy});" << std::endl;

	// arguments between 0 and 1
	dir = std::complex<double>(0, 0.01);
	for (double re = 0.2; re < 1; re += 0.2) {
		std::complex<double>	startz(re, 0.001);
		std::complex<double>	startw = ct.startpoint(startz);
		startw = std::complex<double>(startw.real(), 0);
		curvetracer::curve_t	curve = ct.trace(startz, dir,
			startw, 1000);
		cdp->color("red");
		(*cdp)(curve);
		(*cdp)(curvetracer::mirrorx(curve));
		cdp->color("blue");
		(*cdp)(curvetracer::mirrory(curve));
		(*cdp)(curvetracer::mirror(curve));
	}

	// argument 1 (singularity)
	{
		std::complex<double>	startz(1.);
		std::complex<double>	startw(xmax);
		curvetracer::curve_t	curve = ct.trace(startz, dir,
			startw, 1000);
		cdp->color("red");
		(*cdp)(curve);
		(*cdp)(curvetracer::mirrorx(curve));
		cdp->color("blue");
		(*cdp)(curvetracer::mirror(curve));
		(*cdp)(curvetracer::mirrory(curve));
	}

	// argument 1/k
	{
		std::complex<double>	startz(1/k);
		std::complex<double>	startw(xmax, ymax);
		curvetracer::curve_t	curve = ct.trace(startz, dir,
			startw, 1000);
		cdp->color("red");
		(*cdp)(curve);
		(*cdp)(curvetracer::mirrorx(curve));
		cdp->color("blue");
		(*cdp)(curvetracer::mirror(curve));
		(*cdp)(curvetracer::mirrory(curve));
	}

	// border
	(*cdp->out()) << "\\def\\xmax{" << xmax << "}" << std::endl;
	(*cdp->out()) << "\\def\\ymax{" << ymax << "}" << std::endl;

	return EXIT_SUCCESS;
}
