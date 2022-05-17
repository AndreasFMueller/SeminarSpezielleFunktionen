//
// dreiecke3d.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

union {
	seite(A, B, fett)
	seite(B, C, fett)
	seite(A, C, fett)
	punkt(A, fett)
	punkt(B, fett)
	punkt(C, fett)
	punkt(P, fine)
	seite(B, P, fine)
	seite(C, P, fine)
	pigment {
		color dreieckfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(A, B, C, fine)
	pigment {
		color rot
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(B, C, A, fine)
	pigment {
		color gruen
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(C, A, B, fine)
	pigment {
		color blau
	}
	finish {
		specular 0.95
		metallic
	}
}