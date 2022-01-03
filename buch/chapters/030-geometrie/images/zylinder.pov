//
// zylinder.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.064;
#declare r = 0.025;
#declare R = 1.3 * r;

camera {
	location <-43, 20, 40>
	look_at <1, 0.65, 2.1>
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	<-40, 20, 10> color White
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

arrow(<-1.5,0,0>, <1.5,0,0>, r, White)
arrow(<0,-1,0>, <0,2.5,0>, r, White)
arrow(<0,0,-1.5>, <0,0,2*pi+0.5>, r, White)

#declare cylindercolor = rgb<0.6,0.8,1.0>;
#declare transparentcylinder = rgbf<0.6,0.8,1.0,0.7>;
#declare planecolor = rgb<0.2,0.8,0.4>;
#declare transparentplane = rgbf<0.2,0.8,0.4,0.7>;

difference {
	cylinder { <0,0,0>, <0,2,0>, 1 }
	cylinder { <0,-1,0>, <0,3,0>, 0.99 }
	pigment {
		color transparentcylinder
	}
	finish {
		specular 0.9
		metallic
	}
}


box {
	<1,0,0>, <0.99,2,2*pi>
	pigment {
		color transparentplane
	}
	finish {
		specular 0.9
		metallic
	}
}

#macro punkt(phi) 
	<cos(phi), phi/pi, sin(phi)>
#end
#macro geschwindigkeit(phi)
	<-sin(phi), 1/pi, cos(phi)>
#end

union {
	#declare N = 100;
	#declare phistep = 2*pi/N;
	#declare phi = 0;
	#declare maxphi = 2*pi;
	#while (phi < maxphi - phistep/2)
		sphere { punkt(phi), r}
		cylinder { punkt(phi), punkt(phi+phistep), r }
		#declare phi = phi + phistep;
	#end
	sphere { punkt(phi), r}
	pigment {
		color Red
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	sphere { <1,0,0>, r }
	sphere { <1,2,2*pi>, r }
	cylinder { <1,0,0>, <1,2,2*pi>, r }
	pigment {
		color Orange
	}
	finish {
		specular 0.95
		metallic
	}
}

#declare winkel = (130/180) * pi;

#declare rr = 0.5 * r;

union {
	sphere { <0,winkel/pi,0>, rr }
	sphere { punkt(winkel), rr }
	cylinder { <0,winkel/pi,0>, punkt(winkel), rr }
	sphere { <cos(winkel), 0, sin(winkel)>, rr }
	sphere { <cos(winkel), 2, sin(winkel)>, rr }
	cylinder { <cos(winkel), 2, sin(winkel)>, <0, 2, 0>, rr }
	sphere { <0,2,0>, rr }
	sphere { <cos(winkel), 0, sin(winkel)>, rr }
	cylinder { <cos(winkel), 0, sin(winkel)>, <0, 0, 0>, rr }
	sphere { <0,0,0>, rr }
	cylinder {
		<cos(winkel), 0, sin(winkel)>
		<cos(winkel), 2, sin(winkel)>
		rr
	}
	pigment {
		color White
	}
	finish {
		specular 0.95
		metallic
	}
}

#declare geschwindigkeitsfarbe = rgb<1,0.6,1>;

arrow(punkt(winkel), punkt(winkel) + geschwindigkeit(winkel), r, geschwindigkeitsfarbe)

sphere { punkt(winkel), 1.3 * r 
	pigment {
		color geschwindigkeitsfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}
