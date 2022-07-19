//
// dreiecke3d.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

kugel(kugeldunkel)

union {
	seite(A, B, fett)
	seite(B, C, fett)
	seite(A, C, fett)
	punkt(A, fett)
	punkt(B, fett)
	punkt(C, fett)
	punkt(P, fein)
	seite(B, P, fein)
	seite(C, P, fein)
	pigment {
		color dreieckfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

