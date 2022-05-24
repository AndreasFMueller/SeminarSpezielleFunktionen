/*
 * spherecurve.cpp
 *
 * (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <string>
#include <iostream>

inline double	sqr(double x) { return x * x; }

/**
 * \brief Class for 3d vectors (also used as colors)
 */
class vector {
	double	X[3];
public:
	vector() { X[0] = X[1] = X[2] = 0; }
	vector(double a) { X[0] = X[1] = X[2] = a; }
	vector(double x, double y, double z) {
		X[0] = x; X[1] = y; X[2] = z;
	}
	vector(double theta, double phi) {
		double	s = sin(theta);
		X[0] = cos(phi) * s;
		X[1] = sin(phi) * s;
		X[2] = cos(theta);
	}
	vector(const vector& other) {
		for (int i = 0; i < 3; i++) {
			X[i] = other.X[i];
		}
	}
	vector	operator+(const vector& other) const {
		return vector(X[0] + other.X[0],
				X[1] + other.X[1],
				X[2] + other.X[2]);
	}
	vector	operator*(double l) const {
		return vector(X[0] * l, X[1] * l, X[2] * l);
	}
	double	operator*(const vector& other) const {
		double	s = 0;
		for (int i = 0; i < 3; i++) {
			s += X[i] * other.X[i];
		}
		return s;
	}
	double	norm() const {
		double	s = 0;
		for (int i = 0; i < 3; i++) {
			s += sqr(X[i]);
		}
		return sqrt(s);
	}
	vector	normalize() const {
		double	l = norm();
		return vector(X[0]/l, X[1]/l, X[2]/l);
	}
	double	max() const {
		return std::max(X[0], std::max(X[1], X[2]));
	}
	double	l0norm() const {
		double	l = 0;
		for (int i = 0; i < 3; i++) {
			if (fabs(X[i]) > l) {
				l = fabs(X[i]);
			}
		}
		return l;
	}
	vector	l0normalize() const {
		double	l = l0norm();
		vector	result(X[0]/l, X[1]/l, X[2]/l);
		return result;
	}
	const double&	operator[](int i) const { return X[i]; }
	double&	operator[](int i) { return X[i]; }
};

/**
 * \brief Derived 3d vector class implementing color
 *
 * The constructor in this class converts a single value into a
 * color on a suitable gradient.
 */
class color : public vector {
public:
	static double	utop;
	static double	ubottom;
	static double	green;
public:
	color(double u) {
		u = (u - ubottom) / (utop - ubottom);
		if (u > 1) {
			u = 1;
		}
		if (u < 0) {
			u = 0;
		}
		u = pow(u,2);
		(*this)[0] = u;
		(*this)[1] = green;
		(*this)[2] = 1-u;
		double	l = l0norm();
		for (int i = 0; i < 3; i++) {
			(*this)[i] /= l;
		}
	}
};

double	color::utop = 12;
double	color::ubottom = -31;
double	color::green = 0.5;

/**
 * \brief Surface model
 *
 * This class contains the definitions of the functions to plot
 * and the parameters to 
 */
class surfacefunction {
	static vector	axes[6];

	double	_a;
	double	_A;

	double	_umin;
	double	_umax;
public:
	double	a() const { return _a; }
	double	A() const { return _A; }

	double	umin() const { return _umin; }
	double	umax() const { return _umax; }

	surfacefunction(double a, double A) : _a(a), _A(A), _umin(0), _umax(0) {
	}

	double	f(double z) {
		return A() * exp(a() * (sqr(z) - 1));
	}

	double	g(double z) {
		return -f(z) * 2*a() * ((2*a()*sqr(z) + (3-2*a()))*sqr(z) - 1);
	}

	double	F(const vector& v) {
		double	s = 0;
		for (int i = 0; i < 6; i++) {
			s += f(axes[i] * v);
		}
		return s / 6;
	}

	double	G(const vector& v) {
		double	s = 0;
		for (int i = 0; i < 6; i++) {
			s += g(axes[i] * v);
		}
		return s / 6;
	}
protected:
	color	farbe(const vector& v) {
		double	u = G(v);
		if (u < _umin) {
			_umin = u;
		}
		if (u > _umax) {
			_umax = u;
		}
		return color(u);
	}
};

static double	phi = (1 + sqrt(5)) / 2;
static double	sl = sqrt(sqr(phi) + 1);
vector	surfacefunction::axes[6] = {
	vector(   0.   , -1./sl, phi/sl ),
	vector(   0.   ,  1./sl, phi/sl ),
	vector(   1./sl, phi/sl,  0.    ),
	vector(  -1./sl, phi/sl,  0.    ),
	vector(  phi/sl,  0.   ,  1./sl ),
	vector( -phi/sl,  0.   ,  1./sl )
};

/**
 * \brief Class to construct the plot
 */
class surface : public surfacefunction {
	FILE	*outfile;

	int	_phisteps;
	int	_thetasteps;
	double	_hphi;
	double	_htheta;
public:
	int	phisteps() const { return _phisteps; }
	int	thetasteps() const { return _thetasteps; }
	double	hphi() const { return _hphi; }
	double	htheta() const { return _htheta; }
	void	phisteps(int s) { _phisteps = s; _hphi = 2 * M_PI / s; }
	void	thetasteps(int s) { _thetasteps = s; _htheta = M_PI / s; }

	surface(const std::string& filename, double a, double A)
		: surfacefunction(a, A) {
		outfile = fopen(filename.c_str(), "w");
		phisteps(400);
		thetasteps(200);
	}

	~surface() {
		fclose(outfile);
	}

private:
	void	triangle(const vector& v0, const vector& v1, const vector& v2) {
		fprintf(outfile, "    mesh {\n");
		vector	c = (v0 + v1 + v2) * (1./3.);
		vector	color = farbe(c.normalize());
		vector	V0 = v0 * (1 + F(v0));
		vector	V1 = v1 * (1 + F(v1));
		vector	V2 = v2 * (1 + F(v2));
		fprintf(outfile, "\ttriangle {\n");
		fprintf(outfile, "\t    <%.6f,%.6f,%.6f>,\n",
			V0[0], V0[2], V0[1]);
		fprintf(outfile, "\t    <%.6f,%.6f,%.6f>,\n",
			V1[0], V1[2], V1[1]);
		fprintf(outfile, "\t    <%.6f,%.6f,%.6f>\n",
			V2[0], V2[2], V2[1]);
		fprintf(outfile, "\t}\n");
		fprintf(outfile, "\tpigment { color rgb<%.4f,%.4f,%.4f> }\n",
			color[0], color[1], color[2]);
		fprintf(outfile, "\tfinish { metallic specular 0.5 }\n");
		fprintf(outfile, "    }\n");
	}

	void	northcap() {
		vector	v0(0, 0, 1);
		for (int i = 1; i <= phisteps(); i++) {
			fprintf(outfile, "    // northcap i = %d\n", i);
			vector	v1(htheta(), (i - 1) * hphi());
			vector	v2(htheta(),  i      * hphi());
			triangle(v0, v1, v2);
		}
	}

	void	southcap() {
		vector	v0(0, 0, -1);
		for (int i = 1; i <= phisteps(); i++) {
			fprintf(outfile, "    // southcap i = %d\n", i);
			vector	v1(M_PI - htheta(), (i - 1) * hphi());
			vector	v2(M_PI - htheta(),  i      * hphi());
			triangle(v0, v1, v2);
		}
	}

	void	zone() {
		for (int j = 1; j < thetasteps() - 1; j++) {
			for (int i = 1; i <= phisteps(); i++) {
				fprintf(outfile, "    // zone j = %d, i = %d\n",
					j, i);
				vector v0( j    * htheta(), (i-1) * hphi());
				vector v1((j+1) * htheta(), (i-1) * hphi());
				vector v2( j    * htheta(),  i    * hphi());
				vector v3((j+1) * htheta(),  i    * hphi());
				triangle(v0, v1, v2);
				triangle(v1, v2, v3);
			}
		}
	}
public:
	void	draw() {
		northcap();
		southcap();
		zone();
	}
};

/**
 * \brief main function
 */
int	main(int argc, char *argv[]) {
	surface	S("spherecurve.inc", 5, 10);
	color::green = 0.3;
	S.draw();
	std::cout << "umin: " << S.umin() << std::endl;
	std::cout << "umax: " << S.umax() << std::endl;
	return EXIT_SUCCESS;
}
