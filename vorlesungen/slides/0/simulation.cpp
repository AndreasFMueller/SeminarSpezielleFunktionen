/*
 * simulation.cpp
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <ImageMagick-7/Magick++.h>
#include <string>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <cmath>
#include <getopt.h>

class v {
	double	_data[2];
public:
	v(double x, double y) {
		_data[0] = x;
		_data[1] = y;
	}
	v() {
		_data[0] = 0;
		_data[1] = 0;
	}
	double&	operator[](int i) { return _data[i]; }
	const double&	operator[](int i) const { return _data[i]; }
	v	operator+(const v& other) const { 
		v	result;
		result[0] = _data[0] + other[0];
		result[1] = _data[1] + other[1];
		return result;
	}
	v	operator-(const v& other) const { 
		v	result;
		result[0] = _data[0] - other[0];
		result[1] = _data[1] - other[1];
		return result;
	}
	v	operator*(double l) const {
		v	result;
		result[0] = l * _data[0];
		result[1] = l * _data[1];
		return result;
	}
	Magick::Coordinate	coordinate() {
		return Magick::Coordinate(_data[0], _data[1]);
	}
};

v	f(const v& x) {
	v	result;
	result[0] = -x[1];
	result[1] =  x[0];
	return result;
}

v	rkstep(const v& x, double h) {
	v	k1 = f(x);
	v	k2 = f(x + k1 * (h/2));
	v	k3 = f(x + k2 * (h/2));
	v	k4 = f(x + k3 * h);
	return x + (k1 + k2 * 2 + k3 * 2 + k4) * (h/6);
}

v	rotation(const v& x0, int steps) {
	double	h = 2 * M_PI / steps;
	v	x = x0;
	for (int i = 0; i < steps; i++) {
		x = rkstep(x, h);
	}
	return x;
}

v	rotations(const v& x0, int rot, int steps) {
	v	x = x0;
	for (int i = 0; i < rot; i++) {
		x = rotation(x, steps);
	}
	return x;
}

struct option	longoptions[] = {
{ "width",	required_argument,	NULL,	'w' },
{ "height",	required_argument,	NULL,	'h' },
{ "scale",	required_argument,	NULL,	'S' },
{ "steps",	required_argument,	NULL,	's' },
{ "rotations",	required_argument,	NULL,	'r' },
{ "iterations",	required_argument,	NULL,	'i' },
{ NULL,		0,			NULL,	 0  }
};

int	main(int argc, char *argv[]) {
	Magick::InitializeMagick(*argv);
	int	width = 1920;
	int	height = 1080;
	double	scale = 500;
	int	steps = 80;
	int	nrotations = 40000;
	int	iterations = 200;
	int	c;
	int	longindex;
	std::string	outputpath;
	while (EOF != (c = getopt_long(argc, argv, "w:h:S:s:r:i:", longoptions, &longindex)))
		switch (c) {
		case 'w':
			width = std::stoi(optarg);
			break;
		case 'h':
			height = std::stoi(optarg);
			break;
		case 'S':
			scale = std::stod(optarg);
			break;
		case 's':
			steps = std::stoi(optarg);
			break;
		case 'r':
			nrotations = std::stoi(optarg);
			break;
		case 'i':
			iterations = std::stoi(optarg);
			break;
		}

	if (optind < argc) {
		outputpath = std::string(argv[optind++]);
	}

	Magick::Geometry	geometry(width, height);
	std::string	backgroundcolorspec("white");
	std::string	axescolorspec("black");
	std::string	curvecolorspec("red");
	Magick::ColorRGB	background(backgroundcolorspec);
	Magick::ColorRGB	axescolor(axescolorspec);
	Magick::ColorRGB	curvecolor(curvecolorspec);
	Magick::ColorRGB	transparent("transparent");

	Magick::Image	image(geometry, background);
	image.strokeColor(axescolor);

	// draw axes
	std::vector<Magick::Drawable>	objects_to_draw;
	objects_to_draw.push_back(Magick::DrawableStrokeWidth(5));
	objects_to_draw.push_back(Magick::DrawableLine(0,540, 1919, 540));
	objects_to_draw.push_back(Magick::DrawableLine(960,0,960,1079));
	image.draw(objects_to_draw);

	// compute rotations and errors an plot the errors
	v	x0(1,0);
	v	x = x0;
	v	offset(980, 540);
	image.strokeColor(curvecolor);
	Magick::CoordinateList	path;
	path.push_back((x - x0 + offset).coordinate());
	for (int n = 0; n < iterations; n++) {
		//v	from = (x - x0) * 100;
		x = rotations(x, nrotations, steps);
		v	to = (x - x0) * scale + offset;
		std::cout << "(" << to[0] << "," << to[1] << ")" << std::endl;
		path.push_back(to.coordinate());
		std::vector<Magick::Drawable>	segments;
		segments.push_back(Magick::DrawableFillColor(transparent));
		segments.push_back(Magick::DrawableStrokeWidth(5));
		segments.push_back(Magick::DrawablePolyline(path));
		image.draw(segments);

		// write the image if the output path is set
		if (outputpath.size() > 0) {
			char	buffer[1024];
			snprintf(buffer, sizeof(buffer), "%s%05d.jpg",
				outputpath.c_str(), n);
			image.write(buffer);
		}
	}

	// write the image
	image.write("test.jpg");
}
