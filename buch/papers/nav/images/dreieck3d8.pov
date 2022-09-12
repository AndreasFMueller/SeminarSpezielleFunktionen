//
// dreiecke3d8.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

union {
	seite(A, B, fett)
	seite(B, C, fett)
	seite(A, C, fett)
	seite(A, P, fein)
	seite(B, P, fett)
	seite(C, P, fett)
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
	winkel(A, B, C, fein, klein)
	pigment {
		color rot
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(B, C, A, fein, klein)
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

object {
	winkel(A, P, C, fein/2, gross)
	pigment {
		color rgb<0.8,0,0.8>
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(B, P, C, fein, klein)
	pigment {
		color rgb<1,0.8,0>
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(B, P, A, fein/2, gross)
	pigment {
		color rgb<0.4,0.6,0.8>
	}
	finish {
		specular 0.95
		metallic
	}
}

dreieck(A, B, C, White)

kugel(kugelfarbe)

