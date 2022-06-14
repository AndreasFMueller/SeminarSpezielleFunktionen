//
// kegelpara.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

#declare O = <0,0,0>;

global_settings {
        assumed_gamma 1
}

#declare imagescale = 0.08;

camera {
        location <28, 20, -40>
        look_at <0, 0.1, 0>
        right x * imagescale
        up y * imagescale
}

light_source {
        <30, 10, -40> color White
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

arrow(<-2,0,0>,<2,0,0>,0.02,White)
arrow(<0,-2,0>,<0,2,0>,0.02,White)
arrow(<0,0,-2>,<0,0,2>,0.02,White)

#declare epsilon = 0.001;
#declare l = 1.5;

#macro Kegel(farbe)
union {
	difference {
		cone { O, 0, <l, 0, 0>, l }
		cone { O + <epsilon, 0,0>, 0, <l+epsilon, 0, 0>, l }
	}
	difference {
		cone { O, 0, <-l, 0, 0>, l }
		cone { O + <-epsilon, 0, 0>, 0, <-l-epsilon, 0, 0>, l }
	}
	pigment {
		color farbe
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#macro F(w, r)
	<r * cos(w), r * r/sqrt(2), r * sin(w) >
#end

#macro Paraboloid(farbe)
mesh {
	#declare phi = 0;
	#declare phimax = 2 * pi;
	#declare phisteps = 100;
	#declare phistep = pi / phisteps;
	#declare rsteps = 100;
	#declare rmax = 1.5;
	#declare rstep = rmax / rsteps;
	#while (phi < phimax - phistep/2)
		#declare r = rstep;
		#declare h = r * r / sqrt(2);
		triangle {
			O, F(phi, r), F(phi + phistep, r)
		}
		#while (r < rmax - rstep/2)
			// ring
			triangle {
				F(phi, r),
				F(phi + phistep, r),
				F(phi + phistep, r + rstep)
			}
			triangle {
				F(phi, r),
				F(phi + phistep, r + rstep),
				F(phi, r + rstep)
			}
			#declare r = r + rstep;
		#end
		#declare phi = phi + phistep;
	#end
	pigment {
		color farbe
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#declare a = sqrt(2);
#macro G(phi,sg)
	< a*sg*sqrt(cos(2*phi))*cos(phi), a*cos(2*phi), a*sqrt(cos(2*phi))*sin(phi)>
#end

#macro Lemniskate3D(s, farbe)
union {
	#declare phi = -pi / 4;
	#declare phimax = pi / 4;
	#declare phisteps = 100;
	#declare phistep = phimax / phisteps;
	#while (phi < phimax - phistep/2)
		sphere { G(phi,1), s }
		cylinder { G(phi,1), G(phi+phistep,1), s }
		sphere { G(phi,-1), s }
		cylinder { G(phi,-1), G(phi+phistep,-1), s }
		#declare phi = phi + phistep;
	#end
	pigment {
		color farbe
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#declare a = sqrt(2);
#macro G2(phi,sg)
	a * sqrt(cos(2*phi)) * < sg * cos(phi), 0, sin(phi)>
#end

#macro Lemniskate(s, farbe)
union {
	#declare phi = -pi / 4;
	#declare phimax = pi / 4;
	#declare phisteps = 100;
	#declare phistep = phimax / phisteps;
	#while (phi < phimax - phistep/2)
		sphere { G2(phi,1), s }
		cylinder { G2(phi,1), G2(phi+phistep,1), s }
		sphere { G2(phi,-1), s }
		cylinder { G2(phi,-1), G2(phi+phistep,-1), s }
		#declare phi = phi + phistep;
	#end
	pigment {
		color farbe
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#macro Projektion(s, farbe)
union {
	#declare phistep = pi / 16;
	#declare phi = -pi / 4 + phistep;
	#declare phimax = pi / 4;
	#while (phi < phimax - phistep/2)
		cylinder { G(phi,  1), G2(phi,  1), s }
		cylinder { G(phi, -1), G2(phi, -1), s }
		#declare phi = phi + phistep;
	#end
	pigment {
		color farbe
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#declare kegelfarbe = rgbt<0.2,0.6,0.2,0.2>;
#declare paraboloidfarbe = rgbt<0.2,0.6,1.0,0.2>;

Paraboloid(paraboloidfarbe)
Kegel(kegelfarbe)
Lemniskate3D(0.02, Blue)
Lemniskate(0.02, Red)
Projektion(0.01, Yellow)
