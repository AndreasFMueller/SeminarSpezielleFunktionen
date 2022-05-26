//
// dreiecke3d8.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

//union {
//	seite(A, B, fein)
//	seite(B, C, fein)
//	seite(A, C, fein)
//	seite(A, P, fein)
//	seite(B, P, fett)
//	seite(C, P, fett)
//	punkt(A, fein)
//	punkt(B, fett)
//	punkt(C, fett)
//	punkt(P, fett)
//	pigment {
//		color dreieckfarbe
//	}
//	finish {
//		specular 0.95
//		metallic
//	}
//}

//dreieck(A, B, C, White)

kugel(kugeltransparent)

ebenerwinkel(O, C, P, 0.01, 1.001, rot)
ebenerwinkel(P, C, P, 0.01, 0.3, rot)
komplement(P, C, P, 0.01, 0.3, Yellow)

ebenerwinkel(O, B, P, 0.01, 1.001, blau)
ebenerwinkel(P, B, P, 0.01, 0.3, blau)
komplement(P, B, P, 0.01, 0.3, Green)

arrow(B, 1.5 * B, 0.015, White)
arrow(C, 1.5 * C, 0.015, White)
arrow(P, 1.5 * P, 0.015, White)

union {
	cylinder { O, P, 0.7 * fein }

	cylinder { P, P + 3 * B, 0.7 * fein }
	cylinder { O, B + 3 * B, 0.7 * fein }

	cylinder { P, P + 3 * C, 0.7 * fein }
	cylinder { O, C + 3 * C, 0.7 * fein }

	pigment {
		color White
	}
}

#declare imagescale = 0.044;

camera {
	location <40, 20, -20>
	look_at <0, 0.24, -0.20>
	right x * imagescale
	up y * imagescale
}

