//
// curvature.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//

#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.09;

camera {
	location <10, 10, -40>
	look_at <0, 0, 0>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<-10, 10, -40> color White
	area_light <1,0,0> <0,0,1>, 10, 10
	adaptive 1
	jitter
}

sky_sphere {
	pigment {
		color rgb<1,1,1>
	}
}

//
// draw an arrow from <from> to <to> with thickness <arrowthickness> with
// color <c>
//
#macro arrow(from, to, arrowthickness, c)
#declare arrowdirection = vnormalize(to - from);
#declare arrowlength = vlength(to - from);
union {
	sphere {
		from, 1.1 * arrowthickness
	}
	cylinder {
		from,
		from + (arrowlength - 5 * arrowthickness) * arrowdirection,
		arrowthickness
	}
	cone {
		from + (arrowlength - 5 * arrowthickness) * arrowdirection,
		2 * arrowthickness,
		to,
		0
	}
	pigment {
		color c
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

arrow(<-3.1,0,0>, <3.1,0,0>, 0.01, White)
arrow(<0,-1,0>, <0,1,0>, 0.01, White)
arrow(<0,0,-2.1>, <0,0,2.1>, 0.01, White)

#include "curvature.inc"

#declare sigma = 1;
#declare s = 1.4;
#declare N0 = 0.4;
#declare funktion = function(r) {
	(exp(-r*r/(sigma*sigma)) / sigma
	-
	exp(-r*r/(2*sigma*sigma)) / (sqrt(2)*sigma)) / N0
};
#declare hypot = function(xx, yy) { sqrt(xx*xx+yy*yy) };

#declare Funktion = function(x,y) { funktion(hypot(x+s,y)) - funktion(hypot(x-s,y)) };
#macro punkt(xx,yy)
	<xx, Funktion(xx, yy), yy>
#end

#declare griddiameter = 0.006;
union {
	#declare xmin = -3;
	#declare xmax = 3;
	#declare ymin = -2;
	#declare ymax = 2;


	#declare xstep = 0.2;
	#declare ystep = 0.02;
	#declare xx = xmin;
	#while (xx < xmax + xstep/2)
		#declare yy = ymin;
		#declare P = punkt(xx, yy);
		#while (yy < ymax - ystep/2)
			#declare yy = yy + ystep;
			#declare Q = punkt(xx, yy);
			sphere { P, griddiameter }
			cylinder { P, Q, griddiameter }
			#declare P = Q;
		#end
		sphere { P, griddiameter }
		#declare xx = xx + xstep;
	#end

	#declare xstep = 0.02;
	#declare ystep = 0.2;
	#declare yy = ymin;
	#while (yy < ymax + ystep/2)
		#declare xx = xmin;
		#declare P = punkt(xx, yy);
		#while (xx < xmax - xstep/2)
			#declare xx = xx + xstep;
			#declare Q = punkt(xx, yy);
			sphere { P, griddiameter }
			cylinder { P, Q, griddiameter }
			#declare P = Q;
		#end
		sphere { P, griddiameter }
		#declare yy = yy + ystep;
	#end

	pigment {
		color rgb<0.8,0.8,0.8>
	}
	finish {
		metallic
		specular 0.8
	}
}

