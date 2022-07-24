//
// position3.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "common.inc"

dreieck(A, B, C, kugelfarbe)

union {
	punkt(A, fett)
	punkt(B, fett)
	punkt(C, fett)
	pigment {
		color dreieckfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	seite(A, B, fett)
	seite(A, C, fett)
	pigment {
		color bekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	seite(B, C, fett)
	pigment {
		color unbekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(A, B, C, fein, gross)
	pigment {
		color bekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	winkel(B, C, A, fein, gross)
	winkel(C, A, B, fein, gross)
	pigment {
		color unbekannt
	}
	finish {
		specular 0.95
		metallic
	}
}


