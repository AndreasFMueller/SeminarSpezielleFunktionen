//
// schale.pov -- 
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"

#declare O = <0,0,0>;

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.036;

camera {
        location <40, 20, -20>
        look_at <0, 0.5, 0>
        right 16/9 * x * imagescale
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

sphere {
	<0, 0, 0>, 1
	pigment {
		color rgb<0.8,0.8,0.8>
	}
	finish {
		specular 0.95
		metallic
	}
}

#declare stripcolor = rgb<0.2,0.2,0.8>;

#declare R = 1.002;

#macro punkt(phi,theta)
R * < cos(phi) * cos(theta), sin(theta), sin(phi) * cos(theta) > 
#end

#declare N = 24;
#declare thetaphi = 0.01;
#declare thetawidth = pi * 0.008;
#declare theta = function(phi) { phi * thetaphi }

#declare axisdiameter = 0.007;

cylinder {
	< 0, -2, 0>, < 0, 2, 0>, axisdiameter
	pigment {
		color White
	}
	finish {
		specular 0.95
		metallic
	}
}

#declare curvaturecircle = 0.008;
#declare curvaturecirclecolor = rgb<0.4,0.8,0.4>;

#declare phit = 12.8 * 2 * pi;
#declare P = punkt(phit, theta(phit));
#declare Q = <0, R / sin(theta(phit)), 0>;

#declare e1 = vnormalize(P - Q) / tan(theta(phit));
#declare e2 = vnormalize(vcross(e1, <0,1,0>)) / tan(theta(phit));
#declare psimin = -0.1 * pi;
#declare psimax = 0.1 * pi;
#declare psistep = (psimax - psimin) / 30;

union {
	#declare psi = psimin;
	#declare K = Q + cos(psi) * e1 + sin(psi) * e2;
	#while (psi < psimax - psistep/2)
		sphere { K, curvaturecircle }
		#declare psi = psi + psistep;
		#declare K2 = Q + cos(psi) * e1 + sin(psi) * e2;
		cylinder { K, K2, curvaturecircle }
		#declare K = K2;
	#end
	sphere { K, curvaturecircle }
	pigment {
		color curvaturecirclecolor
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	mesh {
		#declare psi = psimin;
		#declare K = Q + cos(psi) * e1 + sin(psi) * e2;
		#while (psi < psimax - psistep/2)
			#declare psi = psi + psistep;
			#declare K2 = Q + cos(psi) * e1 + sin(psi) * e2;
			triangle { K, K2, Q }
			#declare K = K2;
		#end
	}
	pigment {
		color rgbt<0.4,0.8,0.4,0.5>
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	sphere { P, 0.02 }
	sphere { Q, 0.02 }
	cylinder { P, Q, 0.01 }
	pigment {
		color Red
	}
	finish {
		specular 0.95
		metallic
	}
}

#declare phisteps = 300;
#declare phistep = 2 * pi / phisteps;
#declare phimin = 0;
#declare phimax = N * 2 * pi;

object {
	mesh {
		#declare phi = phimin;
		#declare Poben = punkt(phi, theta(phi) + thetawidth);
		#declare Punten = punkt(phi, theta(phi) - thetawidth);
		triangle { O, Punten, Poben }
		#while (phi < phimax - phistep/2)
			#declare phi = phi + phistep;
			#declare Poben2 = punkt(phi, theta(phi) + thetawidth);
			#declare Punten2 = punkt(phi, theta(phi) - thetawidth);
			triangle { O, Punten, Punten2 }
			triangle { O, Poben, Poben2 }
			triangle { Punten, Punten2, Poben }
			triangle { Punten2, Poben2, Poben }
			#declare Poben = Poben2;
			#declare Punten = Punten2;
		#end
		triangle { O, Punten, Poben }
	}
	pigment {
		color stripcolor
	}
	finish {
		specular 0.8
		metallic
	}
}

union {
	#declare phi = phimin;
	#declare P = punkt(phi, theta(phi));
	#while (phi < phimax - phistep/2)
		sphere { P, 0.003 }
		#declare phi = phi + phistep;
		#declare P2 = punkt(phi, theta(phi));
		cylinder { P, P2, 0.003 }
		#declare P = P2;
	#end
	sphere { P, 0.003 }
	pigment {
		color stripcolor
	}
	finish {
		specular 0.8
		metallic
	}
}
