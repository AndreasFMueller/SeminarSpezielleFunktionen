//
// common.inc -- 3d Darstellung
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.034;

#declare O = <0, 0, 0>;
#declare A = vnormalize(< 0, 1, 0>);
#declare B = vnormalize(< 1, 2, -8>);
#declare C = vnormalize(< 5, 1, 0>);
#declare P = vnormalize(< 5, -1, -7>);

camera {
	location <40, 20, -20>
	look_at <0, 0.24, -0.20>
	right x * imagescale
	up y * imagescale
}

light_source {
	<10, 10, -40> color White
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

#macro grosskreis(normale, staerke)
union {
	#declare v1 = vcross(normale, <normale.x, normale.z, normale.y>);
	#declare v1 = vnormalize(v1);
	#declare v2 = vnormalize(vcross(v1, normale));
	#declare phisteps = 100;
	#declare phistep = pi / phisteps;
	#declare phi = 0;
	#declare p1 = v1;
	#while (phi < 2 * pi - phistep/2)
		sphere { p1, staerke }
		#declare phi = phi + phistep;
		#declare p2 = v1 * cos(phi) + v2 * sin(phi);
		cylinder { p1, p2, staerke }
		#declare p1 = p2;
	#end
}
#end

#macro seite(p, q, staerke)
	#declare n = vcross(p, q);
	intersection {
		grosskreis(n, staerke)
		plane { -vcross(n, q) * vdot(vcross(n, q), p), 0 }
		plane { -vcross(n, p) * vdot(vcross(n, p), q), 0 }
	}
#end

#macro winkel(w, p, q, staerke, r)
	#declare n = vnormalize(w);
	#declare pp = vnormalize(p - vdot(n, p) * n);
	#declare qq = vnormalize(q - vdot(n, q) * n);
	intersection {
		sphere { O, 1 + staerke }
		cone { O, 0, 1.2 * vnormalize(w), r }
		plane { -vcross(n, qq) * vdot(vcross(n, qq), pp), 0 }
		plane { -vcross(n, pp) * vdot(vcross(n, pp), qq), 0 }
	}
#end

#macro punkt(p, staerke)
	sphere { p, 1.5 * staerke }
#end

#macro dreieck(p, q, r, farbe)
	#declare n1 = vnormalize(vcross(p, q));
	#declare n2 = vnormalize(vcross(q, r));
	#declare n3 = vnormalize(vcross(r, p));
	intersection {
		plane { n1, 0 }
		plane { n2, 0 }
		plane { n3, 0 }
		sphere { <0, 0, 0>, 1 + 0.001 }
		pigment {
			color farbe
		}
		finish {
			metallic
			specular 0.4
		}
	}
#end

#macro ebenerwinkel(a, p, q, s, r, farbe)
	#declare n = vnormalize(-vcross(p, q));
	#declare np = vnormalize(-vcross(p, n));
	#declare nq = -vnormalize(-vcross(q, n));
//	arrow(a, a + n, 0.02, White)
//	arrow(a, a + np, 0.01, Red)
//	arrow(a, a + nq, 0.01, Blue)
	intersection {
		cylinder { a - (s/2) * n, a + (s/2) * n, r }
		plane { np, vdot(np, a) }
		plane { nq, vdot(nq, a) }
		pigment {
			farbe
		}
		finish {
			metallic
			specular 0.5
		}
	}
#end

#macro komplement(a, p, q, s, r, farbe)
	#declare n = vnormalize(-vcross(p, q));
//	arrow(a, a + n, 0.015, Orange)
	#declare m = vnormalize(-vcross(q, n));
//	arrow(a, a + m, 0.015, Pink)
	ebenerwinkel(a, p, m, s, r, farbe)
#end

#declare fett = 0.015;
#declare fein = 0.010;

#declare klein = 0.3;
#declare gross = 0.4;

#declare dreieckfarbe = rgb<0.6,0.6,0.6>;
#declare rot = rgb<0.8,0.2,0.2>;
#declare gruen = rgb<0,0.6,0>;
#declare blau = rgb<0.2,0.2,0.8>;

#declare kugelfarbe = rgb<0.8,0.8,0.8>;
#declare kugeltransparent = rgbt<0.8,0.8,0.8,0.5>;

#macro kugel(farbe)
sphere {
	<0, 0, 0>, 1
	pigment {
		color farbe
	}
}
#end

