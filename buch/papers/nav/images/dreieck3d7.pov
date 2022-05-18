//
// dreiecke3d.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

union {
	seite(A, C, fett)
	seite(A, P, fett)
	seite(C, P, fett)

	seite(A, B, fine)
	seite(B, C, fine)
	seite(B, P, fine)
	punkt(A, fett)
	punkt(C, fett)
	punkt(P, fett)
	punkt(B, fine)
	pigment {
		color dreieckfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(A, P, C, fine)
	pigment {
		color rgb<0.4,0.4,1>
	}
	finish {
		specular 0.95
		metallic
	}
}

