//
// membran.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"
#include "math.inc"
#include "membran.inc"

global_settings {
        assumed_gamma 1
}

#declare imagescale = 0.037;

camera {
	location <-33, 20, 50>
	look_at <0, -0.005, 0>
	right x * imagescale
	up (9/32) * y * imagescale
}

background { color rgbt <0,0,0,1> }

light_source {
	<10, 15, 40> color White
	area_light <1,0,0> <0,0,1>, 10, 10
	adaptive 1
        jitter
}

//sky_sphere {
//	pigment {
//		color rgb<1,1,1>
//	}
//}

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

//arrow(<-1.1,0,0>, <1.1,0,0>, 0.01, White)
//arrow(<0,-1.1,0>, <0,1.1,0>, 0.01, White)
//arrow(<0,0,-1.1>, <0,0,1.1>, 0.01, White)

mesh {
	flaeche()
	pigment {
		color rgb<0.8,0.8,0.8> * 1.2
	}
	finish {
		specular 0.95
		metallic
	}
}

#declare randr = 0.01;

#macro zylinder(k,n,r)
	cylinder {
		< cos((2*k+1)*pi/(2*n)), 0, sin((2*k+1)*pi/(2*n)) >,
		< -cos((2*k+1)*pi/(2*n)), 0, -sin((2*k+1)*pi/(2*n)) >,
		r
	}
#end

#macro ring(R,r)
	#declare phisteps = 100;
	#declare phistep = 2 * pi / 100;
	#declare phimin = 0;
	#declare phimax = 2 * pi;
	#declare phi = phimin;
	#while (phi < phimax - phistep/2)
		cylinder {
			<R*cos(phi), 0, R*sin(phi)>,
			<R*cos(phi+phistep), 0, R*sin(phi+phistep)>,
			r
		}
		sphere {
			<R*cos(phi), 0, R*sin(phi)>, r
		}
		#declare phi = phi + phistep;
	#end
#end

#declare nullstelle = 13.0152;

union {
	ring(1, randr)
	pigment {
		color rgb<1.0,0.8,0.6>
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	zylinder(0, 3, 0.5*randr)
	zylinder(1, 3, 0.5*randr)
	zylinder(2, 3, 0.5*randr)
	ring(6.3802/nullstelle, 0.5*randr)
	ring(9.7610/nullstelle, 0.5*randr)
	pigment {
		color rgb<1.0,0.8,0.6>
	}
	finish {
		specular 0.95
		metallic
	}
}

#declare r = 0.2*randr;
union {
	phigitter()
	pigment {
		color rgb<0.2,0.6,1.0>
	}
	finish {
		specular 0.95
		metallic
	}
}
union {
	rgitter()
	pigment {
		color rgb<1.0,0.4,0.6>
	}
	finish {
		specular 0.95
		metallic
	}
}
