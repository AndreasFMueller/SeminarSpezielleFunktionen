//
// macros.inc -- 3d Darstellung
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

//
// Dimensions
//
#declare fett = 0.015;
#declare fein = 0.010;

#declare klein = 0.3;
#declare gross = 0.4;

//
// colors
//
#declare dreieckfarbe = rgb<0.6,0.6,0.6>;
#declare rot = rgb<0.8,0.2,0.2>;
#declare gruen = rgb<0,0.6,0>;
#declare blau = rgb<0.2,0.2,0.8>;

#declare bekannt = rgb<0.2,0.6,1>;
#declare unbekannt = rgb<1.0,0.6,0.8>;

#declare kugelfarbe = rgb<0.8,0.8,0.8>;
#declare kugeldunkel = rgb<0.4,0.4,0.4>;
#declare kugeltransparent = rgbt<0.8,0.8,0.8,0.5>;

#declare gitterfarbe = rgb<0.2,0.6,1>;

//
// Points Points
//
#declare O = <0, 0, 0>;
#declare Nordpol = vnormalize(< 0, 1, 0>);
#declare A = vnormalize(< 0, 1, 0>);
#declare B = vnormalize(< 1, 2, -8>);
#declare C = vnormalize(< 5, 1, 0>);
#declare P = vnormalize(< 5, -1, -7>);

//
// \brief convert spherical coordinates to recctangular coordinates
//
// \param phi 
// \param theta
//
#macro kugelpunkt(phi, theta)
	< sin(theta) * cos(phi - pi), cos(theta), sin(theta) * sin(phi - pi) >
#end

#declare Sakura = kugelpunkt(radians(140.2325498), radians(90 -   35.71548014));
#declare Deneb  = kugelpunkt(radians(191.9397759), radians(90 -   45.361194));
#declare Spica  = kugelpunkt(radians(82.9868559),  radians(90 - (-11.279666)));
#declare Altair = kugelpunkt(radians(179.3616609), radians(90 -    8.928416));
#declare Arktur = kugelpunkt(radians(95.5647759),  radians(90 -   19.063222));

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

#declare ntsteps = 100;

//
// \brief Draw a circle
//
// \param b1	basis vector for a coordinate system of the plane containing
//		the circle
// \param b2	the other basis vector
// \param o	center of the circle
// \param thick	diameter of the circular tube
//
#macro kreis(b1, b2, o, thick, maxwinkel)
	#declare tpstep = pi / ntsteps;
	#declare tp = tpstep;
	#declare p1 = b1 + o;
	sphere { p1, thick }
	#declare tpstep = pi/ntsteps;
	#while (tp < (maxwinkel - tpstep/2))
		#declare p2 = cos(tp) * b1 + sin(tp) * b2 + o;
		cylinder { p1, p2, thick }
		sphere { p2, thick }
		#declare p1 = p2;
		#declare tp = tp + tpstep;
	#end
	#if ((tp - tpstep) < maxwinkel)
		#declare p2 = cos(maxwinkel) * b1 + sin(maxwinkel) * b2 + o;
		cylinder { p1, p2, thick }
		sphere { p2, thick }
	#end
#end

//
// \brief Draw a great circle
//
// \param normale	the normal of the plane containing the great circle
// \param thick		diameter
//
#macro grosskreis(normale, thick)
	#declare other = < normale.y, -normale.x, normale.z >;
	#declare b1 = vnormalize(vcross(other, normale));
	#declare b2 = vnormalize(vcross(normale, b1));
	kreis(b1, b2, <0,0,0>, thick, 2*pi)
#end

//
// \brief Draw a circle of latitude
//
// \param theta		latitude
// \param thick		diameter
//
#macro breitenkreis(theta, thick)
	#declare b1 = sin(theta) * kugelpunkt(0, pi/2);
	#declare b2 = sin(theta) * kugelpunkt(pi/2, pi/2);
	#declare o = < 0, cos(theta), 0 >;
	kreis(b1, b2, o, thick, 2*pi)
#end

//
// \brief Draw the great circle connecting the two points
//
// \param p		first point
// \param q		second point
// \param staerke	diameter
//

#macro seite(p, q, staerke)
	#declare s1 = vnormalize(p);
	#declare s2 = vnormalize(q);
	#declare w = acos(vdot(s1, s2));
	#declare n = vnormalize(vcross(p, q));
	#declare s2 = vnormalize(vcross(n, s1));
	kreis(s1, s2, O, staerke, w)
#end

//
// \brief Draw an angle
//
// \param w		the edge where the angle is located
// \param p		point on the first leg
// \param q		point on the second leg
// \param r		diameter of the angle
//
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

//
// \brief Draw a point on the sphere as a circle
//
// \param p		the point
// \param staerke	the diameter of the point
//
#macro punkt(p, staerke)
	sphere { p, 1.5 * staerke }
#end

//
// \brief Draw a circle as a part of the differently colored cutout from 
//        the sphere
//
// \param p		first point of the triangle
// \param q		second point of the triangle
// \param r		third point of the triangle
// \param farbe		color
//
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

//
// \brief 
//
// \param a		axis of the angle
// \param p		first leg
// \param q		second leg
// \param s		thickness of the angle disk
// \param r		radius of the angle disk
// \param farbe		color
//
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

//
// \brief Show the complement angle
//
//
#macro komplement(a, p, q, s, r, farbe)
	#declare n = vnormalize(-vcross(p, q));
//	arrow(a, a + n, 0.015, Orange)
	#declare m = vnormalize(-vcross(q, n));
//	arrow(a, a + m, 0.015, Pink)
	ebenerwinkel(a, p, m, s, r, farbe)
#end

//
// \brief Show a coordinate grid on the sphere
//
// \param farbe		the color of the grid
// \param thick		the line thickness
//
#macro koordinatennetz(farbe, netzschritte, thick)
union {
	// circles of latitude
	#declare theta = pi/(2*netzschritte);
	#declare thetastep = pi/(2*netzschritte);
	#while (theta < pi - thetastep/2)
		breitenkreis(theta, thick)
		#declare theta = theta + thetastep;
	#end
	// cirles of longitude
	#declare phi = 0;
	#declare phistep = pi/(2*netzschritte);
	#while (phi < pi-phistep/2)
		grosskreis(kugelpunkt(phi, pi/2), thick)
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

//
// \brief Display a color of given color
//
// \param farbe		the color
//
#macro kugel(farbe)
sphere {
	<0, 0, 0>, 1
	pigment {
		color farbe
	}
}
#end

//
// \brief Display the earth 
//
#macro erde()
sphere {
	<0, 0, 0>, 1
	pigment {
		image_map {
			png "2k_earth_daymap.png" gamma 1.0
			map_type 1
		}
	}
}
#end

//
// achse
//
#macro achse(durchmesser, farbe)
	cylinder {
		< 0, -1.2, 0 >, <0, 1.2, 0 >, durchmesser
		pigment {
			color farbe
		}
		finish {
			specular 0.9
			metallic
		}
	}
#end
