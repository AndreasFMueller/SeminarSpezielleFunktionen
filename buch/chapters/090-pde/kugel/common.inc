//
// common.inc
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "colors.inc"
#include "math.inc"

global_settings {
        assumed_gamma 1
}

#declare imagescale = 0.035;
#declare thetasteps = 100;
	#declare phisteps = 200;

#declare PositiveColor = rgb<1.0,0.6,0.2>;
#declare NegativeColor = rgb<0.6,0.2,0.6>;

camera {
	location <-33, 20, 50>
	look_at <0, 0, 0>
	right x * imagescale
	up y * imagescale
}

background { color rgbt <0,0,0,1> }

light_source {
	<10, 5, 40> color White
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

#declare P33 = function(X) { (1-X*X) * sqrt(1-X*X) };
#declare P33abl = function(X) { -3*X*sqrt(1-X*X) };
#declare P32 = function(X) { 2.7 * (1-X*X) * X };
#declare P32abl = function(X) { 2.7 * (1-3*X*X) };
#declare P31 = function(X) { (0.75) * (5*X*X-1) * sqrt(1-X*X) };
#declare P31abl = function(X) { 0.75 * (15*X*X-11)*X / sqrt(1-0.9999*X*X) };
#declare P30 = function(X) { (1/2) * (5*X*X-3)*X };
#declare P30abl = function(X) { (1/2) * 15*X*X-3 };

#macro kugel0(phi,theta)
<cos(phi)*sin(theta), cos(theta), sin(phi)*sin(theta)>
#end
#macro kugelphi(phi,theta)
<-sin(phi)*sin(theta), 0, cos(phi)*sin(theta)>
#end
#macro kugeltheta(phi,theta)
<cos(phi)*cos(theta), -sin(theta), sin(phi)*cos(theta)>
#end

#declare fcos = function(phi,eps) { abs(cos(phi)) * (1+eps*sgn(cos(phi))) }
#declare fradius = function(r,eps) { sqrt(abs(r)) * (1+eps*sgn(r)) }

#macro kugel(phi, theta, m, eps)
	#switch (m)
	#case (0)
		fradius(P30(cos(theta)) * cos(m*phi),eps) * kugel0(phi,theta)
	#break
	#case (1)
		fradius(P31(cos(theta)) * cos(m*phi),eps) * kugel0(phi,theta)
	#break
	#case (2)
		fradius(P32(cos(theta)) * cos(m*phi),eps) * kugel0(phi,theta)
	#break
	#case (3)
		fradius(P33(cos(theta)) * cos(m*phi),eps) * kugel0(phi,theta)
	#end
#end

#macro normale(phi, theta, m, eps)
	#switch (m)
	#case (0)
	vnormalize(vcross(
		P30(cos(theta))*(-m)*sin(m*phi)*kugelphi(phi,theta)
		+
		fradius(P30(cos(theta))*cos(m*phi),eps) * kugelphi(phi,theta),
		P30abl(cos(theta))*(-sin(theta))*cos(m*phi) * kugel0(phi,theta)
		+
		fradius(P30(cos(theta))*cos(m*phi),eps) * kugeltheta(phi,theta)
		
	))
	#break
	#case (1)
	vnormalize(vcross(
		P31(cos(theta))*(-m)*sin(m*phi)*kugelphi(phi,theta)
		+
		fradius(P31(cos(theta))*cos(m*phi),eps) * kugelphi(phi,theta),
		P31abl(cos(theta))*(-sin(theta))*cos(m*phi) * kugel0(phi,theta)
		+
		fradius(P31(cos(theta))*cos(m*phi),eps) * kugeltheta(phi,theta)
		
	))
	#break
	#case (2)
	vnormalize(vcross(
		P32(cos(theta))*(-m)*sin(m*phi)*kugelphi(phi,theta)
		+
		fradius(P32(cos(theta))*cos(m*phi),eps) * kugelphi(phi,theta),
		P32abl(cos(theta))*(-sin(theta))*cos(m*phi) * kugel0(phi,theta)
		+
		fradius(P32(cos(theta))*cos(m*phi),eps) * kugeltheta(phi,theta)
		
	))
	#break
	#case (3)
	vnormalize(vcross(
		P33(cos(theta))*(-m)*sin(m*phi)*kugelphi(phi,theta)
		+
		fradius(P33(cos(theta))*cos(m*phi),eps) * kugelphi(phi,theta),
		P33abl(cos(theta))*(-sin(theta))*cos(m*phi) * kugel0(phi,theta)
		+
		fradius(P33(cos(theta))*cos(m*phi),eps) * kugeltheta(phi,theta)
		
	))
	#break
	#end
#end

#macro kugelflaeche(m, eps, farbe)
mesh {
	#declare thetastep = pi / thetasteps;
	#declare thetamin = thetastep;
	#declare thetamax = pi - thetastep;

	#declare phistep = pi / phisteps;
	#declare phimin = 0;
	#declare phimax = 2 * pi;

	#declare phi = phimin;
	#while (phi < phimax - phistep/2)
		triangle {
			kugel(0, 0, m, eps),
			kugel(phi, thetamin, m, eps),
			kugel(phi + phistep, thetamin, m, eps)
		}

		#declare theta = thetamin;
		#while (theta < thetamax - thetastep/2)
			triangle {
				kugel(phi, theta, m, eps),
				kugel(phi + phistep, theta, m, eps),
				kugel(phi + phistep, theta + thetastep, m, eps)
			}
			triangle {
				kugel(phi, theta, m, eps),
				kugel(phi, theta + thetastep, m, eps),
				kugel(phi + phistep, theta + thetastep, m, eps)
			}
			#declare theta = theta + thetastep;
		#end

		triangle {
			kugel(0, pi, m, eps),
			kugel(phi, thetamax, m, eps),
			kugel(phi + phistep, thetamax, m, eps)
		}

		#declare phi = phi + phistep;
	#end
	pigment {
		color farbe
	}
	finish {
		specular 0.95
		metallic
	}
}
#end

//sphere {
//	<0,0,0>, 1
//	pigment {
//		color rgbt<1,1,1,0.7>
//	}
//	finish {
//		specular 0.95
//		metallic
//	}
//}


