//
// position4.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "common.inc"

dreieck(A, B, P, kugelfarbe)

union {
	punkt(A, fett)
	punkt(B, fett)
	punkt(P, fett)
	pigment {
		color dreieckfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	seite(A, P, fett)
	pigment {
		color unbekannt
	}
	finish {
		specular 0.95
		metallic
	}
}


union {
	seite(A, B, fett)
	seite(B, P, fett)
	pigment {
		color bekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(B, P, A, fein, gross)
	pigment {
		color bekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(A, B, P, fein, gross)
	pigment {
		color unbekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

