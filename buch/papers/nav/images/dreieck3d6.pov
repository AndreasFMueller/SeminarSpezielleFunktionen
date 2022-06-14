//
// dreiecke3d.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

kugel(kugeldunkel)

union {
	seite(A, B, fett)
	seite(A, C, fett)
	seite(B, P, fett)
	seite(C, P, fett)
	seite(A, P, fett)
	punkt(A, fett)
	punkt(B, fett)
	punkt(C, fett)
	punkt(P, fett)
	pigment {
		color dreieckfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(B, A, P, fein, gross)
	pigment {
		color rgb<0.6,0.2,0.6>
	}
	finish {
		specular 0.95
		metallic
	}
}

