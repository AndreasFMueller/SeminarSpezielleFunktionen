//
// dreiecke3d.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

kugel(kugelfarbe)

union {
	seite(A, B, fein)
	seite(A, C, fein)
	punkt(A, fein)
	punkt(B, fett)
	punkt(C, fett)
	punkt(P, fett)
	seite(B, C, fett)
	seite(B, P, fett)
	seite(C, P, fett)
	pigment {
		color dreieckfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(B, C, P, fein, gross)
	pigment {
		color rgb<0.6,0.4,0.2>
	}
	finish {
		specular 0.95
		metallic
	}
}

