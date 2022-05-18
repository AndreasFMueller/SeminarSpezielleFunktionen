//
// dreiecke3d.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

union {
	seite(A, B, fine)
	seite(A, C, fine)
	punkt(A, fine)
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

