//
// dreiecke3d.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
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

object {
	winkel(A, B, C, fein, gross)
	pigment {
		color rot
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(B, C, A, fein, gross)
	pigment {
		color gruen
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(C, A, B, fein, gross)
	pigment {
		color blau
	}
	finish {
		specular 0.95
		metallic
	}
}
