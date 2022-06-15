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

#declare imagescale = 0.060;

camera {
        location <28, 20, -40>
        look_at <0, 0.55, 0>
        right (16/9) * x * imagescale
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
arrow(<0,-1.1,0>,<0,2.2,0>,0.02,White)
arrow(<0,0,-1.6>,<0,0,2.4>,0.02,White)

#declare epsilon = 0.001;
#declare l = 1.5;


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

#macro Ebene(l, b, farbe)
mesh {
	triangle { <-l, 0, -b>, < l, 0, -b>, < l, 0,  b> }
	triangle { <-l, 0, -b>, < l, 0,  b>, <-l, 0,  b> }
	pigment {
		color farbe
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#macro Ebenengitter(l, b, s, r, farbe)
union {
	#declare lmax = floor(l / s);
	#declare ll = -lmax;
	#while (ll <= lmax)
		cylinder { <ll * s, 0, -b>, <ll * s, 0, b>, r }
		#declare ll = ll + 1;
	#end
	#declare bmax = floor(b / s);
	#declare bb = -bmax;
	#while (bb <= bmax)
		cylinder { <-l, 0, bb * s>, <l, 0, bb * s>, r }
		#declare bb = bb + 1;
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

#declare b = 0.5;
#macro T(phi, theta)
	b * < (2 + cos(theta)) * cos(phi), (2 + cos(theta)) * sin(phi) + 1, sin(theta) >
#end

#macro breitenkreis(theta, r)
	#declare phi = 0;
	#declare phimax = 2 * pi;
	#declare phisteps = 200;
	#declare phistep = phimax / phisteps;
	#while (phi < phimax - phistep/2)
		cylinder { T(phi, theta), T(phi + phistep, theta), r }
		sphere { T(phi, theta), r }
		#declare phi = phi + phistep;
	#end
#end

#macro laengenkreis(phi, r)
	#declare theta = 0;
	#declare thetamax = 2 * pi;
	#declare thetasteps = 200;
	#declare thetastep = thetamax / thetasteps;
	#while (theta < thetamax - thetastep/2)
		cylinder { T(phi, theta), T(phi, theta + thetastep), r }
		sphere { T(phi, theta), r }
		#declare theta = theta + thetastep;
	#end
#end

#macro Torusgitter(farbe, r)
union {
	#declare phi = 0;
	#declare phimax = 2 * pi;
	#declare phistep = pi / 6;
	#while (phi < phimax - phistep/2)
		laengenkreis(phi, r)
		#declare phi = phi + phistep;
	#end
	#declare thetamax = pi;
	#declare thetastep = pi / 6;
	#declare theta = thetastep;
	#while (theta < thetamax - thetastep/2)
		breitenkreis(theta, r)
		breitenkreis(thetamax + theta, r)
		#declare theta = theta + thetastep;
	#end
	breitenkreis(0, 1.5 * r)
	breitenkreis(pi, 1.5 * r)
	pigment {
		color farbe
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

#macro Torus(farbe)
mesh {
	#declare phi = 0;
	#declare phimax = 2 * pi;
	#declare phisteps = 200;
	#declare phistep = phimax/phisteps;
	#while (phi < phimax - phistep/2)
		#declare theta = 0;
		#declare thetamax = 2 * pi;
		#declare thetasteps = 200;
		#declare thetastep = thetamax / thetasteps;
		#while (theta < thetamax - thetastep/2)
			triangle {
				T(phi,           theta),
				T(phi + phistep, theta),
				T(phi + phistep, theta + thetastep)
			}
			triangle {
				T(phi,           theta),
				T(phi + phistep, theta + thetastep),
				T(phi,           theta + thetastep)
			}
			#declare theta = theta + thetastep;
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

#declare torusfarbe = rgbt<0.2,0.6,0.2,0.2>;
#declare ebenenfarbe = rgbt<0.2,0.6,1.0,0.2>;

Lemniskate(0.02, Red)
Ebene(1.8, 1.4, ebenenfarbe)
Ebenengitter(1.8, 1.4, 0.5, 0.005, rgb<0.4,1,1>)
Torus(torusfarbe)
Torusgitter(Yellow, 0.005)
