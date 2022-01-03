//
// kegelschnitte.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.090;
#declare r = 0.03;
#declare R = 1.3 * r;

camera {
	location <-33, 20, 50>
	look_at <0, -1.30, 0>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<10, 5, 40> color White
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

//arrow(<-5,0,0>, <5,0,0>, r, White)
//arrow(<0,-2,0>, <0,2,0>, r, White)
//arrow(<0,0,-2>, <0,0,2>, r, White)

#declare kegelfarbe = rgb<0.2,0.6,0.6>;
#declare kegelfarbetransparent = rgbt<0.6,0.6,0.6,0.7>;
#declare fokusfarbe = rgb<1,0.2,0.2>;
#declare scheitelfarbe = rgb<0.0,0.6,0.0>;
#declare kurvenfarbe = rgb<0.4,0.8,0>;
#declare leitfarbe = rgb<0.8,0.2,0.8>;
#declare ebenenfarbe = rgbt<0.6,0.4,0.2,0.0>;

#declare kegelhoehe = 3;
#declare kegelradius = 1.4;

#macro kegel(X)
union {
	cone { <X,0,0>, 0, <X,-kegelhoehe,0>, kegelradius }
	cone { <X,0,0>, 0, <X,kegelhoehe,0>, kegelradius }
}
#end

#macro ebene(X, normale, abstand, anteil)
difference {
	intersection {
		box {
			<X - anteil*(kegelradius + 0.00), -kegelhoehe, 10>,
			//<X - 0.2, -kegelhoehe, 10>,
			<X + 0.9*(kegelradius + 0.00), kegelhoehe, -10>
		}
		plane { normale, abstand + 0.001 }
		plane { -normale, -abstand + 0.001 }
	}
	kegel(X)
	no_shadow
	pigment {
		color ebenenfarbe
	}
	finish {
		specular 0.5
		metallic
	}
}
#end

#declare nparabel = vnormalize(<0, kegelradius, kegelhoehe>);
#declare nparabel2 = vnormalize(<0, kegelradius, -kegelhoehe>);
#declare nellipse = vnormalize(<0, kegelradius + 2, kegelhoehe>);
#declare nellipse2 = vnormalize(<0, kegelradius + 2, -kegelhoehe>);
#declare nhyperbel = vnormalize(<0, kegelradius - 1, kegelhoehe>);

#declare offsetparabel = -0.6;
#declare offsetellipse = -1.1;
#declare offsethyperbel = 0.4;

//
// Hyperbel
//
ebene(3, nhyperbel, offsethyperbel, 0.0)
intersection {
	plane { nhyperbel, offsethyperbel }
	kegel(3)
	pigment {
		color kegelfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

intersection {
	plane { -nhyperbel, -offsethyperbel-0.001 }
	kegel(3)
	no_shadow
	pigment {
		color kegelfarbetransparent
	}
	finish {
		specular 0.5
		metallic
	}
}


#declare e3 = <0, 1, 0>;
#declare tunten = -offsethyperbel / vdot(nparabel-nhyperbel, e3);
#declare toben = offsethyperbel / vdot(nparabel+nhyperbel, e3);
#declare winkel = acos(vdot(nparabel, nhyperbel));

#declare Cunten = e3 * tunten + <3,0,0>;
#declare Coben = e3 * toben + <3,0,0>;

#declare runten = -(vdot(Cunten, nhyperbel) - offsethyperbel);
#declare Funten = Cunten + runten * nhyperbel;
#declare Punten = Cunten + runten * nparabel;
#declare Sunten = Cunten + runten * vnormalize(nparabel+nhyperbel) / cos(winkel/2);

#declare roben = -(vdot(Coben, nhyperbel) - offsethyperbel);
#declare Foben = Coben + roben * nhyperbel;
#declare Poben = Coben - roben * nparabel2;
#declare Soben = Coben + roben * vnormalize(-nparabel2+nhyperbel) / cos(winkel/2);

#declare Origin = (Soben + Sunten) / 2;
#declare xaxis = vnormalize(Sunten - Origin);
#declare yaxis = <1,0,0>;

#declare a = vlength(Sunten - Soben) / 2;
#declare e = vlength(Foben - Funten) / 2;
#declare b = sqrt(e*e - a*a);

#macro hyperbel(s)
	Origin + (a * cosh(s) * xaxis + b * sinh(s) * yaxis)
#end

#macro hyperbelneg(s)
	Origin + (-a * cosh(s) * xaxis + b * sinh(s) * yaxis)
#end

#declare rkurve = 0.6 * r;

// Hyperbel
union {
	#declare N = 100;
	#declare smin = -1.72;
	#declare smax = -smin;
	#declare sstep = (smax - smin) / N;
	#declare s = smin;
	#while (s < smax - sstep/2)
		cylinder { hyperbel(s), hyperbel(s+sstep), rkurve }
		cylinder { hyperbelneg(s), hyperbelneg(s+sstep), rkurve }
		sphere { hyperbel(s), rkurve }
		sphere { hyperbelneg(s), rkurve }
		#declare s = s + sstep;
	#end
	sphere { hyperbel(s), rkurve }
	sphere { hyperbelneg(s), rkurve }
	pigment {
		color kurvenfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

// Brennpunkte
union {
	sphere { Funten, r }
	sphere { Foben, r }
	pigment {
		color  fokusfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

// Scheitelpunkte
union {
	sphere { Sunten, r }
	sphere { Soben, r }
	pigment {
		color  scheitelfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

#declare swert = -1.3;
union {
	sphere { hyperbel(swert), r }
	cylinder { Funten, hyperbel(swert), rkurve }
	cylinder { Foben, hyperbel(swert), rkurve }
	pigment {
		color  Yellow
	}
	finish {
		specular 0.9
		metallic
	}
}
//
// Parabeln
//
intersection {
	plane { nparabel, offsetparabel }
	kegel(0)
	pigment {
		color kegelfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

intersection {
	plane { -nparabel, -offsetparabel+0.001 }
	kegel(0)
	//no_shadow
	pigment {
		color kegelfarbetransparent
	}
	finish {
		specular 0.5
		metallic
	}
}

ebene(0, nparabel, offsetparabel, 0.5)

#declare tcenter = 0.5 * offsetparabel / vdot(nparabel, e3);
#declare C = tcenter * e3;
#declare F = C + 0.5 * offsetparabel * nparabel;
#declare S = <0, tcenter, tcenter * (kegelradius/kegelhoehe) >;
#declare xaxis = vnormalize(F - S);
#declare p = 4 * vlength(S - F);

#declare L = S + (S-F);

#macro parabel(Y)
	(S + Y * yaxis + Y * (Y/p) * xaxis)
#end
#macro leitgerade(Y)
	L + Y * yaxis
#end

//
// Parabel
//
union {
	#declare ymin = -1.19;
	#declare ymax = -ymin;
	#declare ystep = (ymax - ymin) / N;
	#declare Y = ymin;
	#while (Y < ymax - ystep/2)
		sphere { parabel(Y), rkurve }
		cylinder { parabel(Y), parabel(Y+ystep), rkurve }
		#declare Y = Y + ystep;
	#end
	sphere { parabel(Y), rkurve }
	pigment {
		color kurvenfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	cylinder { leitgerade(ymin), leitgerade(ymax), rkurve }
	sphere { leitgerade(ymin), rkurve}
	sphere { leitgerade(ymax), rkurve}
	pigment {
		color leitfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	sphere { F, r }
	pigment {
		color fokusfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	sphere { S, r }
	pigment {
		color scheitelfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

#declare ywert = -0.7;
union {
	sphere { parabel(ywert), r }
	cylinder { F, parabel(ywert), rkurve }
	cylinder { parabel(ywert), leitgerade(ywert), rkurve }
	sphere { leitgerade(ywert), r }
	pigment {
		color  Yellow
	}
	finish {
		specular 0.9
		metallic
	}
}

//
// Dandelin Kugeln für die Ellipse
//

ebene(-3, nellipse, offsetellipse, 1)
intersection {
	plane { nellipse, offsetellipse }
	kegel(-3)
	pigment {
		color kegelfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

intersection {
	plane { -nellipse, -offsetellipse+0.001 }
	kegel(-3)
	//no_shadow
	pigment {
		color kegelfarbetransparent
	}
	finish {
		specular 0.5
		metallic
	}
}

#declare tunten = -offsetellipse / vdot(nparabel-nellipse, e3);
#declare toben = offsetellipse / vdot(nparabel+nellipse, e3);
#declare winkel = acos(vdot(nparabel, nellipse));
#declare winkel2 = acos(-vdot(nparabel2, nellipse));

#declare Cunten = e3 * tunten + <-3,0,0>;
#declare Coben = e3 * toben + <-3,0,0>;

#declare runten = -(vdot(Cunten, nellipse) - offsetellipse);
#declare Funten = Cunten + runten * nellipse;
#declare Punten = Cunten + runten * nparabel;
#declare Sunten = Cunten + runten * vnormalize(nparabel+nellipse) / cos(winkel/2);

#declare roben = (vdot(Coben, nellipse) - offsetellipse);
#declare Foben = Coben - roben * nellipse;
#declare Poben = Coben + roben * nparabel2;
#declare Soben = Coben - roben * vnormalize(-nparabel2+nellipse) / cos(winkel2/2);

#declare Origin = (Soben + Sunten) / 2;
#declare xaxis = vnormalize(Sunten - Origin);
#declare yaxis = <1,0,0>;

#declare a = vlength(Sunten - Soben) / 2;
#declare e = vlength(Foben - Funten) / 2;
#declare b = sqrt(a*a-e*e);

#macro ellipse(s)
	Origin + (a * cos(s) * xaxis + b * sin(s) * yaxis)
#end

union {
	#declare N = 100;
	#declare smin = -pi;
	#declare smax = -smin;
	#declare sstep = (smax - smin) / N;
	#declare s = smin;
	#while (s < smax - sstep/2)
		cylinder { ellipse(s), ellipse(s+sstep), rkurve }
		sphere { ellipse(s), rkurve }
		#declare s = s + sstep;
	#end
	sphere { ellipse(s), rkurve }
	pigment {
		color kurvenfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	//sphere { Cunten, runten + 0.001 }
	//sphere { Coben, roben + 0.001 }
	sphere { Funten, r }
	sphere { Foben, r }
	pigment {
		color  fokusfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

union {
	sphere { Sunten, r }
	sphere { Soben, r }
	pigment {
		color  scheitelfarbe
	}
	finish {
		specular 0.9
		metallic
	}
}

#declare swert = -1.2;
union {
	sphere { ellipse(swert), r }
	cylinder { Funten, ellipse(swert), rkurve }
	cylinder { Foben, ellipse(swert), rkurve }
	pigment {
		color  Yellow
	}
	finish {
		specular 0.9
		metallic
	}
}
